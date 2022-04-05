document.addEventListener('turbolinks:load', () => {
  const humburger = () => {
    const nav = document.getElementById('navArea');
    const btn = document.querySelector('.toggle_btn');
    const mask = document.getElementById('mask');
    const open = 'open';
    // menu open close
    btn.addEventListener('click', () => {
      if (!nav.classList.contains(open)) {
        nav.classList.add(open);
      } else {
        nav.classList.remove(open);
      }
    });
    // menu close
    mask.addEventListener('click', () => {
      nav.classList.remove(open);
    });
  };
  humburger();
});
