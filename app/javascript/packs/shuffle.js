if (document.URL.match(/shuffle/)) {
  document.addEventListener('DOMContentLoaded', () => {
    document.addEventListener('turbolinks:load', () => {
      const memberArray = document.getElementById('member');
      const member = JSON.parse(memberArray.getAttribute('data-member-status'));
      const memberCount = Object.keys(member).length

      /////数字だけの配列定義 0〜memberのオブジェクト数
      const arrayNumber = []
      for (let i = 0; i < memberCount + 1; i++) {
        arrayNumber.push(i)
      }

      //////シャッフル関数 arrayNumberの数字をシャッフル
      const shuffleArray = function () {
        for (let i = memberCount; i > 0; i--) {
          const randomNum = Math.floor(Math.random() * i);
          let tmp = arrayNumber[i - 1];
          arrayNumber[i - 1] = arrayNumber[randomNum];
          arrayNumber[randomNum] = tmp;
        }
      }
    });
  });
}
