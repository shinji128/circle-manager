if (document.URL.match(/event/)) {
  document.addEventListener('turbolinks:load', () => {
    const memberElement = document.getElementById('member');
    const member = JSON.parse(memberElement.getAttribute('data-member-status'));
    const memberCount = Object.keys(member).length

    /////memberのindex配列
    const arrayMemberIndex = []
    for (let i = 1; i < memberCount + 1; i++) {
      arrayMemberIndex.push(i)
    }

    //////シャッフル関数 arrayNumberの数字をシャッフル
    const shuffleArray = () => {
      for (let i = memberCount; i > 0; i--) {
        const randomNum = Math.floor(Math.random() * i);
        let tmp = arrayMemberIndex[i - 1];
        arrayMemberIndex[i - 1] = arrayMemberIndex[randomNum];
        arrayMemberIndex[randomNum] = tmp;
      }
    }

    const resetCourtBlock = (i) => {
      const courtBlock = document.getElementById(`court-block-${i}`)
      courtBlock.removeChild(courtBlock.firstChild)
    }

    const memberHtml = (member) => {
      const html = `<div class= "bg-blue-700 text-white rounded-full py-2 px-4 m-auto" id="play-member">
                      <div class="member_id text-center" id=${member.member_id}>${member.name}</div>
                    </div>`
      return html;
    }

    const buildMemberHtml = (i, arrayNumber) => {
      const courtBlock = document.getElementById(`court-block-${i + 1}`)
      courtBlock.insertAdjacentHTML('beforeend', memberHtml(member[arrayNumber]))
    }

    const shuffle = () => {
      const courtBlockCount = document.querySelectorAll('.court-block').length
      const playMemberCount = document.querySelectorAll('#play-member').length
      if (document.getElementById('play-member')) {
        for (let i = 1; i < playMemberCount + 1; i++) {
          resetCourtBlock(i)
        }
      }
      shuffleArray();
      for (let i = 0; i < courtBlockCount; i++) {
        buildMemberHtml(i, arrayMemberIndex[i])
      }
    }

    const shuffleDone = () => {
      const member_id = document.querySelectorAll('.member_id')
      member_id.forEach(i => {
        const playCount = document.querySelector(`.play-count-${i.id}`)
        member[i.id].play_count++
        playCount.innerHTML = member[i.id].play_count
      })
    }

    const courtHtml = (courtCount, courtBlockCount) => {
      const html = `<div class="court" id="court-${courtCount + 1}">
                      <div class="court-lh">
                        <div class="court-block lhup" id="court-block-${courtBlockCount + 1}"></div>
                        <div class="court-block lhlo" id="court-block-${courtBlockCount + 2}"></div>
                      </div>
                      <div class="court-center"></div>
                      <div class="court-rh">
                        <div class="court-block rhup" id="court-block-${courtBlockCount + 3}"></div>
                        <div class="court-block rhlo" id="court-block-${courtBlockCount + 4}"></div>
                      </div>
                    </div>`
      return html;
    }

    const addCourtHtml = () => {
      const courtCount = document.querySelectorAll('.court').length
      const courtBlockCount = document.querySelectorAll('.court-block').length
      const court = document.getElementById(`court-${courtCount}`)
      court.insertAdjacentHTML('afterend', courtHtml(courtCount, courtBlockCount))
    }

    const deleteCourtHtml = () => {
      const courtCount = document.querySelectorAll('.court').length
      if (courtCount >= 2) {
        const courtId = document.getElementById(`court-${courtCount}`)
        courtId.remove();
      }
    }

    document.getElementById('btn-shuffle').addEventListener('click', shuffle);
    document.getElementById('btn-done').addEventListener('click', shuffleDone);
    document.getElementById('btn-add-court').addEventListener('click', addCourtHtml);
    document.getElementById('btn-delete-court').addEventListener('click', deleteCourtHtml);
  });
}
