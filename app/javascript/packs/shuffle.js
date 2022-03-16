if (document.URL.match(/shuffle/)) {
  document.addEventListener('turbolinks:load', () => {
    const memberArray = document.getElementById('member');
    const member = JSON.parse(memberArray.getAttribute('data-member-status'));
    const memberCount = Object.keys(member).length

    /////数字だけの配列定義 0〜memberのオブジェクト数
    const arrayNumber = []
    for (let i = 0; i < memberCount; i++) {
      arrayNumber.push(i)
    }

    //////シャッフル関数 arrayNumberの数字をシャッフル
    const shuffleArray = () => {
      for (let i = memberCount; i > 0; i--) {
        const randomNum = Math.floor(Math.random() * i);
        let tmp = arrayNumber[i - 1];
        arrayNumber[i - 1] = arrayNumber[randomNum];
        arrayNumber[randomNum] = tmp;
      }
    }
    document.querySelector('#btn-shuffle').addEventListener('click', function () {
      shuffleArray();
      console.log(arrayNumber)
    });

    console.log(member[1].name)
    const hoge = document.getElementById('court-rhlo-1')
    function buildHTML(i) {
      const html = `<div class= "bg-blue-700 text-white rounded-full py-2 px-4 m-auto">
                      <div class="member text-center">${i}</div>
                    </div>`
      return html;
    }
    function addHTML() {
      hoge.insertAdjacentHTML('afterend', buildHTML(member[1].name))
    }

    addHTML();
  });
}
