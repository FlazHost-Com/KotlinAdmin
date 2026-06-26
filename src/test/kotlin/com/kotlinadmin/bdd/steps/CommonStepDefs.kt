package com.kotlinadmin.bdd.steps

import io.cucumber.java.After
import io.cucumber.java.Before
import io.cucumber.java.en.And
import io.cucumber.java.en.Then
import io.cucumber.java.en.When
import io.ktor.client.request.*
import io.ktor.http.*
import io.ktor.server.testing.TestApplication
import com.kotlinadmin.module
import kotlinx.coroutines.runBlocking
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue

class CommonStepDefs {

    @Before
    fun setUp() {
        SharedTestState.reset()
        SharedTestState.testApp = TestApplication {
            application { module() }
        }
    }

    @After
    fun tearDown() {
        SharedTestState.reset()
    }

    @When("I GET {string}")
    fun iGet(path: String) = runBlocking {
        val app = requireNotNull(SharedTestState.testApp)
        SharedTestState.lastResponse = app.client.get(path) {
            val jwt = SharedTestState.jwtToken
            val cookies = SharedTestState.sessionCookies
            if (jwt != null) header(HttpHeaders.Authorization, "Bearer $jwt")
            if (cookies.isNotBlank()) header(HttpHeaders.Cookie, cookies)
        }
    }

    @Then("the response status is {int}")
    fun theResponseStatusIs(expectedStatus: Int) {
        val actual = requireNotNull(SharedTestState.lastResponse) { "No response captured" }.status.value
        assertEquals(expectedStatus, actual, "Expected status $expectedStatus but got $actual")
    }

    @And("I am redirected to {string}")
    fun iAmRedirectedTo(expectedPath: String) {
        val location = SharedTestState.lastResponse?.headers?.get(HttpHeaders.Location)
        assertTrue(
            location?.contains(expectedPath) == true,
            "Expected redirect to $expectedPath, got Location: $location"
        )
    }
}
