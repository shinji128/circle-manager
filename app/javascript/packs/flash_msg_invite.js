document.addEventListener('turbolinks:load', () => {
  const navArea = document.getElementById('navArea')
  const copyTarget = document.getElementById('copyTarget').value

  const addFlashHtml = () => {
    const html = `<div id="alert" class="flex bg-green-100 rounded-lg py-5 px-6 mb-3 text-base text-green-700 items-center w-full" role="alert">
                    <svg aria-hidden="true" class="w-4 h-4 mr-2 fill-current" data-icon="check-circle" data-prefix="fas" focusable="false" role="img" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg">
                      <path d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" fill="currentColor"></path></path>
                    </svg>
                    招待リンクをコピーしました
                  </div>`
    return html;
  }

  const removeFlashHtml = () => {
    const flashMessage = document.getElementById('alert');
    flashMessage.remove()
  }

  const copyToClipboard = () => {
    navigator.clipboard.writeText(copyTarget)
    const flashMessage = document.getElementById('alert');
    if (flashMessage === null) {
      navArea.insertAdjacentHTML('beforeend', addFlashHtml())
    }
    setTimeout(removeFlashHtml, 3000)
  }

  document.getElementById('btn-invite').addEventListener('click', copyToClipboard);
});
