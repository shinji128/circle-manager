document.addEventListener('turbolinks:load', () => {
  const attendanceStates = document.querySelectorAll('#attendance-state');

  const stateClass = (state, parent) => {
    if (state.innerHTML == '未定') {
      parent.classList.add('present-state')
    } else if (state.innerHTML == '出席') {
      parent.classList.add('absent-state')
    } else if (state.innerHTML == '欠席') {
      parent.classList.add('undecided-state')
    } else {
      parent.classList.add('no-exit-state')
    }
  };

  const classAdd = () => {
    for (state of attendanceStates) {
      stateClass(state, state.parentNode);
    }
  }

  classAdd();
});
