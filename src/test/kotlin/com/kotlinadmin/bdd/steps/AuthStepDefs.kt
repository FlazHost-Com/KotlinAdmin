package com.kotlinadmin.bdd.steps

import io.cucumber.java.en.And
import io.cucumber.java.en.Given
import io.cucumber.java.en.When
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import org.junit.jupiter.api.Assertions.assertTrue

class AuthStepDefs {

    @Given("the application is running")
    fun theApplicationIsRunning() {
        requireNotNull(SharedTestState.testApp) { "TestApplication was not created in @Before" }
    }

    @When("I POST to {string} with email {string} and password {string}")
    fun iPostFormLogin(path: String, email: String, password: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        SharedTestState.lastResponse = app.client.post(path) {
            contentType(ContentType.Application.FormUrlEncoded)
            setBody("email=${email.encodeURLParameter()}&password=${password.encodeURLParameter()}&_csrf=test-csrf-token")
        }
        SharedTestState.sessionCookies = SharedTestState.lastResponse!!.headers[HttpHeaders.SetCookie] ?: ""
    }

    @When("I POST to {string} with JSON body email {string} password {string}")
    fun iPostJsonLogin(path: String, email: String, password: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        SharedTestState.lastResponse = app.client.post(path) {
            contentType(ContentType.Application.Json)
            setBody("""{"email":"$email","password":"$password"}""")
        }
        if (SharedTestState.lastResponse!!.status.isSuccess()) {
            val body = Json.parseToJsonElement(SharedTestState.lastResponse!!.bodyAsText())
            SharedTestState.jwtToken = body.jsonObject["token"]?.jsonPrimitive?.content
        }
    }

    @Given("I am logged in via API as {string} with password {string}")
    fun iAmLoggedInViaApi(email: String, password: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        val resp = app.client.post("/api/v1/auth/login") {
            contentType(ContentType.Application.Json)
            setBody("""{"email":"$email","password":"$password"}""")
        }
        val body = Json.parseToJsonElement(resp.bodyAsText())
        SharedTestState.jwtToken = body.jsonObject["token"]?.jsonPrimitive?.content
    }

    @When("I GET {string} without authentication")
    fun iGetWithoutAuth(path: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        SharedTestState.lastResponse = app.client.get(path)
    }

    @When("I GET {string} with the same token")
    fun iGetWithSameToken(path: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        SharedTestState.lastResponse = app.client.get(path) {
            val jwt = SharedTestState.jwtToken
            if (jwt != null) header(HttpHeaders.Authorization, "Bearer $jwt")
        }
    }

    @When("I POST to {string} with JWT")
    fun iPostWithJwt(path: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        SharedTestState.lastResponse = app.client.post(path) {
            val jwt = SharedTestState.jwtToken
            if (jwt != null) header(HttpHeaders.Authorization, "Bearer $jwt")
            contentType(ContentType.Application.Json)
            setBody("{}")
        }
    }

    @When("I POST to {string}")
    fun iPost(path: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        SharedTestState.lastResponse = app.client.post(path) {
            val jwt = SharedTestState.jwtToken
            val cookies = SharedTestState.sessionCookies
            if (jwt != null) header(HttpHeaders.Authorization, "Bearer $jwt")
            if (cookies.isNotBlank()) header(HttpHeaders.Cookie, cookies)
            setBody("_csrf=test-csrf-token")
            contentType(ContentType.Application.FormUrlEncoded)
        }
    }

    @And("the response JSON has field {string}")
    fun theResponseJsonHasField(field: String) = runBlocking {
        val body = requireNotNull(SharedTestState.lastResponse).bodyAsText()
        val json = Json.parseToJsonElement(body).jsonObject
        assertTrue(json.containsKey(field), "Expected JSON to contain field '$field', got: $body")
    }
}
