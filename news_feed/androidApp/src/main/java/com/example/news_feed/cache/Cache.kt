package com.example.news_feed.cache

interface Cache<Key: Any, Value: Any> {
    suspend fun get(key: Key) : Value?
    suspend fun set(key:Key, value: Value)

    fun compose(b:Cache<Key, Value>) : Cache<Key, Value> {
        return object : Cache<Key, Value> {
            override suspend fun get(key: Key): Value? {
                return this@Cache.get(key)?: let {
                    b.get(key)?.apply {
                        this@Cache.set(key, this)
                    }
                }
            }

            override suspend fun set(key: Key, value: Value) {
                return listOf(this@Cache.set(key, value),
                    b.set(key, value)).forEach { it }
            }

        }
    }
}