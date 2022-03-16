if (document.URL.match(/shuffle/)) {
  document.addEventListener('turbolinks:load', () => {
    const memberArray = document.getElementById('member');
    const member = JSON.parse(memberArray.getAttribute('data-member-status'));
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

    const CourtLhUp = document.getElementById('court-lhup-1')
    const CourtLhLo = document.getElementById('court-lhlo-1')
    const CourtRhUp = document.getElementById('court-rhup-1')
    const CourtRhLo = document.getElementById('court-rhlo-1')

    const htmlCourtLhUp = (i) => {
      const html = `<div class= "bg-blue-700 text-white rounded-full py-2 px-4 m-auto" id="court-lhup-member">
                      <div class="text-center">${i}</div>
                    </div>`
      return html;
    }

    const htmlCourtLhLo = (i) => {
      const html = `<div class= "bg-blue-700 text-white rounded-full py-2 px-4 m-auto" id="court-lhlo-member">
                      <div class="text-center">${i}</div>
                    </div>`
      return html;
    }

    const htmlCourtRhUp = (i) => {
      const html = `<div class= "bg-blue-700 text-white rounded-full py-2 px-4 m-auto" id="court-rhup-member">
                      <div class="text-center">${i}</div>
                    </div>`
      return html;
    }

    const htmlCourtRhLo = (i) => {
      const html = `<div class= "bg-blue-700 text-white rounded-full py-2 px-4 m-auto" id="court-rhlo-member">
                      <div class="text-center">${i}</div>
                    </div>`
      return html;
    }

    const BuildHtmlCourtLhUp = (i) => {
      CourtLhUp.insertAdjacentHTML('afterend', htmlCourtLhUp(member[i].name))
    }

    const BuildHtmlCourtLhLo = (i) => {
      CourtLhLo.insertAdjacentHTML('afterend', htmlCourtLhLo(member[i].name))
    }

    const BuildHtmlCourtRhUp = (i) => {
      CourtRhUp.insertAdjacentHTML('afterend', htmlCourtRhUp(member[i].name))
    }

    const BuildHtmlCourtRhLo = (i) => {
      CourtRhLo.insertAdjacentHTML('afterend', htmlCourtRhLo(member[i].name))
    }

    document.querySelector('#btn-shuffle').addEventListener('click', () => {
      const courtLhUpMember = document.getElementById('court-lhup-member')
      const courtLhLoMember = document.getElementById('court-lhlo-member')
      const courtRhUpMember = document.getElementById('court-rhup-member')
      const courtRhLoMember = document.getElementById('court-rhlo-member')
      if (courtLhUpMember) {
        courtLhUpMember.remove();
        courtLhLoMember.remove();
        courtRhUpMember.remove();
        courtRhLoMember.remove();
      }
      shuffleArray();
      BuildHtmlCourtLhUp(arrayNumber[0]);
      BuildHtmlCourtLhLo(arrayNumber[1]);
      BuildHtmlCourtRhUp(arrayNumber[2]);
      BuildHtmlCourtRhLo(arrayNumber[3]);
    });
  });
}
