<template>
  <section v-if="operators.length" class="divide-gray-200 divide-y">
    <div
      v-for="operator in operators"
      :key="operator.Registro_ANS"
      class="p-4 hover:bg-gray-50 transition-colors"
    >
      <div class="flex flex-col md:flex-row md:justify-between md:items-center">
        <div>
          <h3 class="font-medium text-blue-900">
            {{ operator.Nome_Fantasia || operator.Razao_Social }}
          </h3>
          <p class="text-sm text-gray-600">{{ operator.Razao_Social }}</p>
          <div class="flex flex-wrap gap-2 mt-2">
            <span
              class="inline-flex items-center text-xs font-medium px-2 py-0.5 rounded bg-blue-100 text-blue-800"
            >
              ANS: {{ operator.Registro_ANS }}
            </span>
            <span
              class="inline-flex items-center text-xs font-medium px-2 py-0.5 rounded bg-gray-100 text-gray-800"
            >
              CNPJ: {{ formatCNPJ(operator.CNPJ) }}
            </span>
            <span
              class="inline-flex items-center text-xs font-medium px-2 py-0.5 rounded bg-green-100 text-green-800"
            >
              {{ operator.Modalidade }}
            </span>
          </div>
        </div>
        <div class="mt-3 md:mt-0">
          <span class="inline-flex items-center text-sm font-medium text-blue-700">
            <span class="mr-1">{{ operator.UF }}</span>
            <LocationIcon />
          </span>
        </div>
      </div>
    </div>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import type { PropType } from 'vue'
import type { Operator } from '@/services/api'
import LocationIcon from '@/assets/icons/LocationIcon.vue'

export default defineComponent({
  components: { LocationIcon },
  props: {
    operators: {
      type: Array as PropType<Operator[]>,
      required: true,
      default: () => [],
    },
  },
  setup() {
    const formatCNPJ = (cnpj: string | null | undefined): string => {
      if (!cnpj) return ''

      const cnpjStr = String(cnpj)
      const numericOnly = cnpjStr.replace(/\D/g, '')

      if (numericOnly.length === 14) {
        return numericOnly.replace(/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/, '$1.$2.$3/$4-$5')
      }

      return cnpjStr
    }

    return { formatCNPJ }
  },
})
</script>
