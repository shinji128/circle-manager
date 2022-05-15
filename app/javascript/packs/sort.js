document.addEventListener('turbolinks:load', () => {
  const touchStartEvent = (event) => {
    // タッチによる画面スクロールを止める
    event.preventDefault();
  }

  const touchMoveEvent = (event) => {
    event.preventDefault();

    // ドラッグ中のアイテムをカーソルの位置に追従
    const touchElem = event.target;
    const touch = event.changedTouches[0];
    if (touchElem.className == 'player') {
      touchElem.style.position = "fixed";
      touchElem.style.top = (touch.pageY - window.pageYOffset - touchElem.offsetHeight / 2) + "px";
      touchElem.style.left = (touch.pageX - window.pageXOffset - touchElem.offsetWidth / 2) + "px";
    } else if (touchElem.className == 'player-name'){
      touchElem.parentElement.style.position = "fixed";
      touchElem.parentElement.style.top = (touch.pageY - window.pageYOffset - touchElem.offsetHeight / 2) + "px";
      touchElem.parentElement.style.left = (touch.pageX - window.pageXOffset - touchElem.offsetWidth / 2) + "px";
    } else {
      touchElem.parentElement.parentElement.style.position = "fixed";
      touchElem.parentElement.parentElement.style.top = (touch.pageY - window.pageYOffset - touchElem.offsetHeight / 2) + "px";
      touchElem.parentElement.parentElement.style.left = (touch.pageX - window.pageXOffset - touchElem.offsetWidth / 2) + "px";
    }
  }

  const styleReset = (item) => {
    item.style.position = '';
    item.style.top = '';
    item.style.left = '';
  }

  const touchEndEvent = (event) => {
    event.preventDefault();
    event.stopPropagation();

    let touchElem = event.target
    // ドラッグ中の操作のために変更していたスタイルを元に戻す
    if (event.target.className == 'player-name') {
      touchElem = event.target.parentElement
    } else if (event.target.className == 'shuffle-badge') {
      touchElem = event.target.parentElement.parentElement
    }
    styleReset(touchElem)

    // ドロップした位置の絶対座標
    const touch = event.changedTouches[0];
    // スクロール分を加味した座標のエレメントを取得
    const dropElem = document.elementFromPoint(touch.pageX - window.pageXOffset, touch.pageY - window.pageYOffset)
    const dropParentElem = dropElem.parentElement
    const dropAncestorElem = dropElem.parentElement.parentElement
    const dropAncestor2Elem = dropElem.parentElement.parentElement.parentElement

    if (dropElem.className.includes('court-block')) {
      touchElem.parentElement.appendChild(dropElem.firstElementChild)
      dropElem.appendChild(touchElem)
    } else if (dropElem.className == 'player') {
      touchElem.parentElement.appendChild(dropElem)
      dropParentElem.appendChild(touchElem)
    } else if (dropElem.className == 'player-name') {
      touchElem.parentElement.appendChild(dropParentElem)
      dropAncestorElem.appendChild(touchElem)
    }
    setMatch();
  }

  const courtPlayers = document.querySelectorAll('.player')
  const playerNames = document.querySelectorAll('.player-name')

  const touchEventSet = (items) => {
    for (let i = 0; i < items.length; ++i) {
      const item = items[i];
      item.addEventListener('touchstart', touchStartEvent, false);
      item.addEventListener('touchmove', touchMoveEvent, false);
      item.addEventListener('touchend', touchEndEvent, false);
    }
  }

  touchEventSet(courtPlayers);
  touchEventSet(playerNames);

  //タップ&ドロップによる試合メンバーをmatch_resultに反映
  const setMatch = () => {
    const users = document.querySelectorAll('.attendance_input')
    const attendanceIds = document.querySelectorAll('#attendance-id')
    for (let i = 0; i < attendanceIds.length; ++i) {
      users[i].value = attendanceIds[i].innerHTML
    }
  }

});
