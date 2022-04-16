document.addEventListener('turbolinks:load', () => {
  const touchStartEvent = (event) => {
    // タッチによる画面スクロールを止める
    event.preventDefault();
  }

  const touchMoveEvent = (event) => {
    event.preventDefault();

    // ドラッグ中のアイテムをカーソルの位置に追従
    const draggedElem = event.target;
    const touch = event.changedTouches[0];
    draggedElem.parentElement.style.position = "fixed";
    draggedElem.parentElement.style.top = (touch.pageY - window.pageYOffset - draggedElem.offsetHeight / 2) + "px";
    draggedElem.parentElement.style.left = (touch.pageX - window.pageXOffset - draggedElem.offsetWidth / 2) + "px";
  }

  const touchEndEvent = (event) => {
    event.preventDefault();

    // ドラッグ中の操作のために変更していたスタイルを元に戻す
    const droppedElem = event.target
    droppedElem.style.position = "";
    event.target.style.top = "";
    event.target.style.left = "";

    const droppedElemParent = event.target.parentElement
    droppedElemParent.style.position = "";
    droppedElemParent.style.top = "";
    droppedElemParent.style.left = "";

    const bench = document.getElementById('members-list')

    // ドロップした位置にあるドロップ可能なエレメントに親子付けする
    const touch = event.changedTouches[0];
    // スクロール分を加味した座標に存在するエレメントを新しい親とする
    const afterElem = document.elementFromPoint(touch.pageX - window.pageXOffset, touch.pageY - window.pageYOffset)
    const beforeElem = event.target.parentElement
    if (afterElem.className.includes('court-block')) {
      beforeElem.parentElement.appendChild(afterElem.firstChild);
      afterElem.appendChild(droppedElem.parentElement);
    } else if (afterElem.className == 'player-name') {
      console.log('player-name')
      afterElem.parentElement.parentElement.appendChild(droppedElem.parentElement);
      const blankCourt = []
      const court = document.querySelectorAll('.court-block')
      for (let i = 0; i < court.length; ++i) {
        const item = court[i];
        if (item.childElementCount == 0) {
          blankCourt.push(item)
        }
      }
      if (blankCourt.length == 0) {
        console.log('hoge')
        bench.appendChild(afterElem.parentElement);
      } else {
        blankCourt[0].appendChild(beforeElem.parentElement)
      }
    } else if (afterElem.className == 'player'){
      afterElem.parentElement.appendChild(droppedElem.parentElement);
      const blankCourt = []
      const court = document.querySelectorAll('.court-block')
      for (let i = 0; i < court.length; ++i) {
        const item = court[i];
        if (item.childElementCount == 0) {
          blankCourt.push(item)
        }
      }
      if (blankCourt.length == 0) {
        bench.appendChild(afterElem);
      } else {
        blankCourt[0].appendChild(afterElem)
      }
    }
  }

  const dragPlayers = document.querySelectorAll('.player-name')
  for (let i = 0; i < dragPlayers.length; ++i) {
    const item = dragPlayers[i];
    item.addEventListener('touchstart', touchStartEvent, false);
    item.addEventListener('touchmove', touchMoveEvent, false);
    item.addEventListener('touchend', touchEndEvent, false);
  }

  const dragBenchPlayers = document.querySelectorAll('.bench-player')
  for (let i = 0; i < dragBenchPlayers.length; ++i) {
    const item = dragBenchPlayers[i];
    item.addEventListener('touchstart', touchStartEvent, false);
    item.addEventListener('touchmove', touchMoveEvent, false);
    item.addEventListener('touchend', touchEndEvent, false);
  }
});
