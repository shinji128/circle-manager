if (document.URL.match(/shuffle/)) {
  document.addEventListener('turbolinks:load', () => {
    const memberElement = document.getElementById('member');
    const member = JSON.parse(memberElement.getAttribute('data-member-status'));
    const memberCount = Object.keys(member).length

    const memberListHtml = (member) => {
      const html = `<div class="bg-blue-700 text-white rounded-full py-2 px-4 m-1 id="member-list">
                      <div class="member-${member.member_id}>
                        ${member.name}
                        <span play-count rounded-full>${member.play_count}</span>
                      </div>
                    </div>`
      return html;
    }

    const buildMemberListHtml = () => {
      for (let i = 1; i < memberCount + 1; i++) {
        memberListHtml(member[i])
      }
    }

    const resetMemberListHtml = () => {
      const memberList = document.querySelectorAll('#member-list')
      memberList.remove()
    }

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
      if (document.getElementById('play-member')) {
        for (let i = 1; i < 5; i++) {
          resetCourtBlock(i)
        }
      }
      shuffleArray();
      for (let i = 0; i < 4; i++) {
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

    document.getElementById('btn-shuffle').addEventListener('click', shuffle);
    document.getElementById('btn-done').addEventListener('click', shuffleDone);

  });
}
