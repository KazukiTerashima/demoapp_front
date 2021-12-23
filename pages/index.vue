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
      <v-card-title>
        VuetifyカスタムCSSの検証
      </v-card-title>
      <v-card-text>
        ipad（768px）とmobile（426px）で表示・非表示
      </v-card-text>
      <v-card-text>
        <v-card
          v-for="(cls, i) in customClass"
          :key="`cls-${i}`"
          :color="cls.color"
          :class="cls.name"
        >
          <v-card-text>
            {{ cls.des }}
          </v-card-text>
        </v-card>
      </v-card-text>
      <v-card-title>
        @nuxtjs/i18nの検証
      </v-card-title>
      <v-card-text>
        <v-simple-table dence>
          <template v-slot:default>
            <thead>
              <tr>
                <td>en</td>
                <td>ja</td>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="(lan, i) in ['signup', 'login']"
                :key="`lan-${i}`"
              >
                <td>{{ lan }}</td>
                <td>{{ $t(`title.${lan}`) }}</td>
              </tr>
            </tbody>
          </template>
        </v-simple-table>
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
      colors: ['primary', 'info', 'success', 'warning', 'error', 'background'],
      customClass: [
        { name: 'hidden-ipad-and-down', color: 'error', des: 'ipad未満で隠す' },
        { name: 'hidden-ipad-and-up', color: 'info', des: 'ipad以上で隠す' },
        { name: 'hidden-mobile-and-down', color: 'success', des: 'mobile未満で隠す' },
        { name: 'hidden-mobile-and-up', color: 'warning', des: 'mobile以上で隠す' },
      ]
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
