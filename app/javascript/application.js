// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function initReveal() {
  const io = new IntersectionObserver(
    es => es.forEach(e => { if (e.isIntersecting) e.target.classList.add('in') }),
    { threshold: 0.08 }
  )
  document.querySelectorAll('.reveal').forEach(el => io.observe(el))
}

function initNavStuck() {
  const nav = document.getElementById('nav')
  if (!nav) return
  const onScroll = () => nav.classList.toggle('stuck', window.scrollY > 40)
  window.removeEventListener('scroll', onScroll)
  window.addEventListener('scroll', onScroll)
  onScroll()
}

function initAnchorScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const href = a.getAttribute('href')
      if (!href || href === '#') return
      const el = document.querySelector(href)
      if (!el) return
      e.preventDefault()
      if (typeof window.closeMob === 'function') window.closeMob()
      el.scrollIntoView({ behavior: 'smooth', block: 'start' })
      history.replaceState(null, '', href)
    })
  })
}

document.addEventListener('turbo:load', () => {
  initNavStuck()
  initReveal()
  initAnchorScroll()
})
