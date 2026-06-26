package com.kotlinadmin.core.helpers

import org.mindrot.jbcrypt.BCrypt
import java.security.SecureRandom

object OtpHelper {
    fun generate(): String {
        val code = SecureRandom().nextInt(1_000_000)
        return code.toString().padStart(6, '0')
    }

    fun hash(otp: String, rounds: Int = 10): String = BCrypt.hashpw(otp, BCrypt.gensalt(rounds))

    fun verify(otp: String, hashed: String): Boolean = BCrypt.checkpw(otp, hashed)

    fun expiry(minutesFromNow: Long = 10L): Long =
        System.currentTimeMillis() + minutesFromNow * 60_000L

    fun isExpired(expiryMs: Long): Boolean = System.currentTimeMillis() > expiryMs
}
