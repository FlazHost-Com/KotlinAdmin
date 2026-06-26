package com.kotlinadmin.bdd.steps

import io.cucumber.java.en.And
import io.cucumber.java.en.Given
import io.cucumber.java.en.When
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonArray
import kotlinx.serialization.json.jsonObject
import kotlinx.serialization.json.jsonPrimitive
import org.junit.jupiter.api.Assertions.assertTrue

class AccessStepDefs {

    @Given("I am logged in as admin")
    fun iAmLoggedInAsAdmin() = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        val resp = app.client.post("/auth/login") {
            contentType(ContentType.Application.FormUrlEncoded)
            setBody("email=admin%40admin.com&password=12345678&_csrf=test-csrf-token")
        }
        SharedTestState.sessionCookies =
            resp.headers.getAll(HttpHeaders.SetCookie)?.joinToString("; ") { it.split(";")[0] } ?: ""

        val apiResp = app.client.post("/api/v1/auth/login") {
            contentType(ContentType.Application.Json)
            setBody("""{"email":"admin@admin.com","password":"12345678"}""")
        }
        if (apiResp.status.isSuccess()) {
            val body = Json.parseToJsonElement(apiResp.bodyAsText())
            SharedTestState.jwtToken = body.jsonObject["token"]?.jsonPrimitive?.content
        }
    }

    @Given("a user exists with email {string} and code {string}")
    fun aUserExistsWithEmailAndCode(email: String, code: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        app.client.post("/admin/v1/access/user/store?_csrf=test-csrf-token") {
            contentType(ContentType.Application.FormUrlEncoded)
            header(HttpHeaders.Cookie, SharedTestState.sessionCookies)
            setBody(
                "code=${code.encodeURLParameter()}" +
                "&name=Test+User" +
                "&email=${email.encodeURLParameter()}" +
                "&password=password123" +
                "&passwordConfirm=password123" +
                "&status=Active" +
                "&timezone=UTC"
            )
        }
        SharedTestState.createdUserIds.add(email)
    }

    @When("I GET {string} with JWT")
    fun iGetWithJwt(path: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        SharedTestState.lastResponse = app.client.get(path) {
            val jwt = SharedTestState.jwtToken
            if (jwt != null) header(HttpHeaders.Authorization, "Bearer $jwt")
        }
    }

    @When("I POST to {string} with CSRF and form fields:")
    fun iPostWithCsrfAndFormFields(path: String, table: io.cucumber.datatable.DataTable) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        val fields = table.asMap<String, String>(String::class.java, String::class.java)
        val body = fields.entries.joinToString("&") { (k, v) ->
            "${k.encodeURLParameter()}=${v.encodeURLParameter()}"
        }
        SharedTestState.lastResponse = app.client.post("$path?_csrf=test-csrf-token") {
            contentType(ContentType.Application.FormUrlEncoded)
            header(HttpHeaders.Cookie, SharedTestState.sessionCookies)
            setBody(body)
        }
    }

    @When("I POST to delete the user with method override {string} and CSRF token")
    fun iDeleteUser(methodOverride: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        val email = SharedTestState.createdUserIds.firstOrNull() ?: return@runBlocking
        val apiListResp = app.client.get("/api/v1/access/user?q_email=${email.encodeURLParameter()}") {
            val jwt = SharedTestState.jwtToken
            if (jwt != null) header(HttpHeaders.Authorization, "Bearer $jwt")
        }
        val bodyText = apiListResp.bodyAsText()
        val userId = try {
            Json.parseToJsonElement(bodyText).jsonObject["data"]
                ?.let { it as? JsonArray }
                ?.firstOrNull()
                ?.jsonObject?.get("id")?.jsonPrimitive?.content
        } catch (e: Exception) { null }

        if (userId != null) {
            SharedTestState.lastCreatedUserId = userId
            SharedTestState.lastResponse = app.client.post(
                "/admin/v1/access/user/$userId/delete?$methodOverride&_csrf=test-csrf-token"
            ) {
                contentType(ContentType.Application.FormUrlEncoded)
                header(HttpHeaders.Cookie, SharedTestState.sessionCookies)
                setBody("")
            }
        }
    }

    @When("I POST to {string} with CSRF and selected user ids")
    fun iPostDeleteSelected(path: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        val apiResp = app.client.get("/api/v1/access/user") {
            val jwt = SharedTestState.jwtToken
            if (jwt != null) header(HttpHeaders.Authorization, "Bearer $jwt")
        }
        val bodyText = apiResp.bodyAsText()
        val ids = try {
            Json.parseToJsonElement(bodyText).jsonObject["data"]
                ?.let { it as? JsonArray }
                ?.mapNotNull { it.jsonObject["id"]?.jsonPrimitive?.content }
                ?: emptyList()
        } catch (e: Exception) { emptyList<String>() }

        val selectedBody = ids.joinToString("&") { "selected%5B%5D=$it" }
        SharedTestState.lastResponse = app.client.post("$path?_csrf=test-csrf-token") {
            contentType(ContentType.Application.FormUrlEncoded)
            header(HttpHeaders.Cookie, SharedTestState.sessionCookies)
            setBody(selectedBody)
        }
    }

    @And("the response contains {string}")
    fun theResponseContains(text: String) = runBlocking {
        val body = requireNotNull(SharedTestState.lastResponse).bodyAsText()
        assertTrue(body.contains(text, ignoreCase = true), "Expected body to contain '$text'")
    }
}
