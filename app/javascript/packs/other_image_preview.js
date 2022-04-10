
document.addEventListener('turbolinks:load', () => {

  const buildHTML = (count) => {
    const html = `<div class="preview-box" id="preview-box-${count}">
                  <div class="image-box">
                    <img src="" alt="preview">
                  </div>
                  <div class="delete-box" id="delete-btn-${count}">
                    削除
                  </div>
                </div>`
    return html;
  }

  const setLabel = () => {
    const labelContent = document.querySelector('.label-content')
    const prevContent = document.querySelector('.prev-content');
    const labelWidth = (300 - prevContent.clientWidth);
    labelContent.style.width = `${labelWidth}px`;
  }

  const UpdateId = (id) => {
    const labelBox = document.querySelector('.label-box')
    labelBox.id = `label-box-${id}`
    labelBox.htmlFor = `other_image_${id}`
  }

  const addImage = () => {
    const prevContent = document.querySelector('.prev-content')
    const id = prevContent.children.length.toString()
    const target = document.getElementById(`other_image_${id}`)
    UpdateId(id);
    const file = target.files[0];
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function() {
      const image = this.result;
      const labelContent = document.querySelector('.label-content')

      const html = buildHTML(id);
      const prevContent = document.querySelector('.prev-content');
      prevContent.insertAdjacentHTML('beforeend', html)
      UpdateId(id);

      const previewBoxImage = document.getElementById(`preview-box-${id}`).firstElementChild
      const previewBoxImageSrc = previewBoxImage.firstElementChild
      previewBoxImageSrc.setAttribute('src', image)
      const count = document.querySelectorAll('.preview-box').length;
      if (count < 5) UpdateId(count);
      if (count == 5) labelContent.style.display = 'none';

      setLabel();
    }
  };

  const ImageDelete = (id) => {
    const prevContent = document.querySelector('.prev-content')
    const count = prevContent.children.length

    const previewBoxId = document.getElementById(`preview-box-${id}`)
    previewBoxId.remove();

    const otherImageId = document.getElementById(`other_image_${id}`)
    otherImageId.value = ''
    if (count == 5) {
      const labelContent = document.querySelector('.label-content')
      labelContent.style.display = 'block'
    }
    if (id < 4) UpdateId(id);
    setLabel();
  };

  document.querySelector('.hidden-content').addEventListener('change', addImage)

  for (let i = 0; i < 5; i++) {
    document.addEventListener('click', function (e) {
      if (e.target.id == `delete-btn-${i}`) {
        ImageDelete(i)
      }
    });
  }
})
