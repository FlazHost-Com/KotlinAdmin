package com.kotlinadmin.bdd.steps

import io.ktor.client.statement.HttpResponse
import io.ktor.server.testing.TestApplication

object SharedTestState {
    var testApp: TestApplication? = null
    var lastResponse: HttpResponse? = null
    var jwtToken: String? = null
    var sessionCookies: String = ""
    var lastCreatedUserId: String? = null
    val createdUserIds: MutableList<String> = mutableListOf()

    fun reset() {
        testApp?.stop()
        testApp = null
        lastResponse = null
        jwtToken = null
        sessionCookies = ""
        lastCreatedUserId = null
        createdUserIds.clear()
    }
}
