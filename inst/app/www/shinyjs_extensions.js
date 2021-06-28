function shinyjs.scroll_to(id, block) {
  document.querySelector('#' + id).scrollIntoView({block: block, behavior: 'smooth'});
}