<template>
  <div class="mt-6 bg-white rounded-lg shadow-md overflow-y-auto max-h-[600px] w-full">
    <div class="p-4 bg-blue-700 text-white flex justify-between items-center">
      <h2 class="font-semibold">Resultados da Busca</h2>
      <span class="bg-blue-100 text-blue-800 text-xs font-medium px-2.5 py-0.5 rounded-full">
        {{ operators.length }} encontrados
      </span>
    </div>

    <div v-if="isLoading" class="flex justify-center items-center p-8">
      <div class="animate-spin rounded-full h-10 w-10 border-t-2 border-b-2 border-blue-500"></div>
      <span class="ml-3 text-gray-600">Buscando operadoras...</span>
    </div>

    <div v-else>
      <!-- Aviso para termos curtos -->
      <div v-if="hasSearched && searchTerm && searchTerm.length < 3" class="p-8 text-center text-red-500">
        <p>O termo de busca deve ter pelo menos 3 caracteres.</p>
      </div>

      <!-- Lista de operadoras -->
      <OperatorList v-else-if="operators.length > 0" :operators="operators" />

      <!-- Nenhum resultado encontrado, mas só mostra se a busca tiver pelo menos 3 caracteres -->
      <div v-else-if="hasSearched && (!searchTerm || searchTerm.length >= 3)" class="p-8 text-center">
        <NoResultsIcon class="h-12 w-12 mx-auto text-gray-400 mb-3" />
        <p class="text-gray-500">Nenhuma operadora encontrada com este termo.</p>
        <p class="text-gray-400 text-sm mt-2">Tente outro termo de busca.</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import OperatorList from './OperatorList.vue'
import NoResultsIcon from '@/assets/icons/NoResultsIcon.vue'

const props = defineProps({
  operators: Array,
  isLoading: Boolean,
  hasSearched: Boolean,
  searchTerm: { type: String, default: '' }
})
</script>
