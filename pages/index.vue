<template>
  <v-container fluid>
    <v-card
      flat
      tile
      color="transparent"
    >
      <v-card-title>
        Usersテーブルの取得
      </v-card-title>
      <v-card-text>
        <v-simple-table dense>
          <template
          v-if="users.length"
            v-slot:default
          >
            <thead>
              <tr>
                <th v-for="(key, i) in userKeys"
                    :key="`key-${i}`">
                  {{ key }}
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="user in users"
                  :key="user.id">
                <th>{{user.id}}</th>
                <th>{{user.name}}</th>
                <th>{{user.email}}</th>
                <th>{{dateFormat(user.created_at)}}</th>
              </tr>
            </tbody>
          </template>
          <template v-else>
            ユーザーが存在しません
          </template>
        </v-simple-table>
      </v-card-text>
      <v-card-title>
        Vuetifyの導入
      </v-card-title>
      <v-card-text>
        <v-btn
          v-for="(color, i) in colors"
          :key="`color-${i}`"
          :color="color"
          class="mr-2"
        >
        {{ color }}
        </v-btn>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  async asyncData({ $axios }) {
    let users = []
    await $axios.$get('/api/v1/users').then(res => (users = res))
    const userKeys = Object.keys(users[0] || {})
    return { users, userKeys }
  },
  data() {
    return {
    colors: ['primary', 'info', 'success', 'warning', 'error', 'background']
    }
  },
  computed: {
    dateFormat() {
      return (date) => {
        const dateTimeFormat = new Intl.DateTimeFormat('ja', { dateStyle: 'medium', timeStyle: 'short' })
        return dateTimeFormat.format(new Date(date))
      }
    }
  }
}
</script>
