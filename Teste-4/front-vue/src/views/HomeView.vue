<template>
  <div class="min-h-dvh bg-[#eef7ff] min-w-full relative">
    <Header />
    <main class="flex flex-col items-center px-4 pb-8 h-[90%]">
      <div class="w-full flex flex-col items-center md:w-2xl">
        <SearchBar @search="fetchResults" />
        <SearchResults
          :operators="operators"
          :isLoading="isLoading"
          :hasSearched="hasSearched"
          :searchTerm="searchTerm"
        />
      </div>
    </main>
    <Footer />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { searchOperators } from '@/services/api'
import Header from '@/components/Header.vue'
import Footer from '@/components/Footer.vue'
import SearchBar from '@/components/SearchBar.vue'
import SearchResults from '@/components/SearchResults.vue'

const operators = ref([])
const isLoading = ref(false)
const hasSearched = ref(false)
const searchTerm = ref('') // Armazena o termo digitado

const fetchResults = async (query) => {
  searchTerm.value = query.trim()

  // Se o campo estiver vazio, reseta os resultados sem marcar como pesquisa feita
  if (!searchTerm.value) {
    operators.value = []
    hasSearched.value = false // Garante que nada será exibido antes da busca
    return
  }

  // Se o termo for muito curto, exibe o aviso
  if (searchTerm.value.length < 3) {
    operators.value = []
    hasSearched.value = true
    return
  }

  isLoading.value = true
  try {
    const result = await searchOperators(searchTerm.value)

    if ('error' in result) {
      console.error('Error fetching operators:', result.error)
      operators.value = []
    } else {
      operators.value = result.operadoras || []
    }
  } catch (error) {
    console.error('Unexpected error:', error)
    operators.value = []
  } finally {
    isLoading.value = false
    hasSearched.value = true
  }
}
</script>
