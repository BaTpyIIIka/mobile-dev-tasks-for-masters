package com.example.news_feed.cache

import com.example.news_feed.model.entity.NewsEntity

class NewsInMemoryCache : Cache<Int, List<NewsEntity>> {

    private var entityList = mutableMapOf<Int, List<NewsEntity>>()

    override suspend fun get(key: Int): List<NewsEntity>? {
        return entityList[key]
    }

    override suspend fun set(key:Int, value: List<NewsEntity>) {
        // I'll remove previous member from memory
        // We'll only have two values stored in memory
        if (entityList.count() == CACHE_SIZE) {
            entityList.remove(entityList.keys.min())
        }
        entityList[key] = value
    }

    companion object {
        const val CACHE_SIZE = 2
    }

}