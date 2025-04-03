<template>
  <div class="w-full">
    <div class="relative w-full">
      <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
        <SearchIcon />
      </div>
      <input
        v-model="searchTerm"
        @input="debounceSearch"
        @keyup.enter="onSearch"
        type="search"
        placeholder="Digite nome fantasia ou razão social da operadora"
        class="w-full p-4 pl-10 text-sm text-gray-900 border border-gray-300 rounded-lg bg-white focus:ring-blue-500 focus:border-blue-500 shadow-sm"
      />
      <button
        @click="onSearch"
        class="absolute right-2.5 bottom-2.5 bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 text-white"
      >
        Buscar
      </button>
    </div>
    <div class="text-xs text-gray-500 mt-2 pl-2">Exemplo: Unimed</div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue'
import SearchIcon from '@/assets/icons/SearchIcon.vue'

export default defineComponent({
  components: { SearchIcon },
  emits: ['search'],
  setup(_, { emit }) {
    const searchTerm = ref('')
    let debounceTimer: number | null = null

    const onSearch = () => {
      if (searchTerm.value.trim()) {
        emit('search', searchTerm.value)
      }
    }

    const debounceSearch = () => {
      if (debounceTimer) {
        clearTimeout(debounceTimer)
      }
      debounceTimer = setTimeout(() => {
        onSearch()
      }, 500) as unknown as number
    }

    return { searchTerm, onSearch, debounceSearch }
  },
})
</script>
