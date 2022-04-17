document.addEventListener('turbolinks:load', () => {
  //コート数の変更
  const courtNum = document.getElementById('court_num')
  const matchPlayNum = document.getElementById('match_play_num')

  const courtNumChange = () => {
    matchPlayNum.value = courtNum.value
  }

  courtNum.addEventListener('change', courtNumChange);
})
