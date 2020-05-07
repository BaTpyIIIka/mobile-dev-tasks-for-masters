package com.example.news_feed.model.source

import org.junit.Test

import org.junit.Assert.*
import kotlinx.coroutines.*

class LocalNewsStorageTest {
    @Test
    fun get_first_item() = runBlocking {
        val source = LocalNewsSource(30)

        val result = source.getNews(0, 1)

        assertEquals(1, result.size)
        assertEquals("Author 1", result[0].author)
    }

    @Test
    fun get_first_n_items() = runBlocking {
        val source = LocalNewsSource(30)

        val result = source.getNews(0, 3)

        assertEquals(3, result.size)
        assertEquals("Author 1", result[0].author)
        assertEquals("Author 2", result[1].author)
        assertEquals("Author 3", result[2].author)
    }

    @Test
    fun get_first_n_items_with_offset() = runBlocking {
        val source = LocalNewsSource(30)

        val result = source.getNews(5, 3)

        assertEquals(3, result.size)
        assertEquals("Author 6", result[0].author)
        assertEquals("Author 7", result[1].author)
        assertEquals("Author 8", result[2].author)
    }

    @Test
    fun get_with_offset_out_of_bound() = runBlocking {
        val source = LocalNewsSource(30)

        val result = source.getNews(50, 3)

        assertEquals(0, result.size)
    }

    @Test
    fun get_with_count_out_of_bound() = runBlocking {
        val source = LocalNewsSource(30)

        val result = source.getNews(27, 10)

        assertEquals(3, result.size)
        assertEquals("Author 28", result[0].author)
        assertEquals("Author 29", result[1].author)
        assertEquals("Author 30", result[2].author)
    }
}
