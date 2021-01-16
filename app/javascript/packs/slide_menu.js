document.addEventListener("DOMContentLoaded", function () {

  const btn = document.getElementById('js-btn-menu');
  const nav = document.querySelector('nav');

  btn.addEventListener('click', () => {
    nav.classList.toggle('open-menu')
    btn.innerHTML = btn.innerHTML === 'メニュー'
    ? '閉じる'
    : 'メニュー'
  });
})