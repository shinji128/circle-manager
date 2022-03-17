if (document.URL.match(/shuffle/)) {
  document.addEventListener('turbolinks:load', () => {
    const memberElement = document.getElementById('member');
    const member = JSON.parse(memberElement.getAttribute('data-member-status'));
    const memberCount = Object.keys(member).length

    /////数字だけの配列定義 0〜memberのオブジェクト数
    const arrayNumber = []
    for (let i = 1; i < memberCount + 1; i++) {
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

    const resetCourtBlock = (i) => {
      const courtBlock = document.getElementById(`court-block-${i}`)
      courtBlock.removeChild(courtBlock.firstChild)
    }

    const memberHtml = (hoge) => {
      const html = `<div class= "bg-blue-700 text-white rounded-full py-2 px-4 m-auto" id="play-member">
                      <div class="text-center">${hoge}</div>
                    </div>`
      return html;
    }

    const buildMemberHtml = (i, arrayNumber) => {
      const courtBlock = document.getElementById(`court-block-${i + 1}`)
      courtBlock.insertAdjacentHTML('beforeend', memberHtml(member[arrayNumber].name))
    }

    const shuffle = () => {
      if (document.getElementById('play-member')) {
        for (let i = 1; i < 5; i++) {
          resetCourtBlock(i)
        }
      }
      shuffleArray();
      for (let i = 0; i < 4; i++) {
        buildMemberHtml(i, arrayNumber[i])
      }
    }

    document.getElementById('btn-shuffle').addEventListener('click', shuffle);

  });
}
