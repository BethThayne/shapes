const duplicateHTML = (element, quantity) => {
		const newContent = new Array(quantity).fill(element.innerHTML).join('')

		element.innerHTML = newContent
}

duplicateHTML(document.querySelector('#crosses'), 10)
anime({
  targets: '#crosses path',
  rotate: '1turn',
  delay: (el, i, l) => i*100,
  duration: 1200,
  loop: true,
  direction: 'alternate',
  easing: 'easeInOutSine',
});


anime({
  targets: '#tunnel circle',
  scale: 1.1,
  direction: 'alternate',
  loop: true,
  duration: 250,
  easing: 'easeInOutCubic',
  delay: (el, index) => index * 50
});

anime({
  targets: '.conveyor',
  translateX: '-50%',
  duration: 1500,
  easing: 'linear',
  loop: true,
autoplay: true
});

//Stolen from https://codepen.io/jakealbaugh/pen/GZwgzV
const zigZagPath = document.querySelector('#zigzag path')
//setDashoffset works out how long the path is
const zigZagOffset = anime.setDashoffset(zigZagPath)
//then we set that back on pathEl
  zigZagPath.setAttribute('stroke-dashoffset', zigZagOffset)
  anime({
    targets: zigZagPath,
    strokeDashoffset: [zigZagOffset, 0],
    duration: anime.random(1000, 3000),
    delay: anime.random(0, 2000),
    loop: true,
    direction: 'alternate',
    easing: 'easeInOutSine',
  });


const wavePath = document.querySelector('#wave path')
const waveOffset = anime.setDashoffset(wavePath)

wavePath.setAttribute('stroke-dashoffset', waveOffset)
anime({
  targets: wavePath,
  strokeDashoffset: [0, waveOffset],
  duration: 2000,
  loop: true,
  direction: 'alternate',
  easing: 'easeInOutSine',
});

duplicateHTML(document.querySelector('#dots'), 40)

const allDots = document.querySelectorAll('#dots .dot');
allDots.forEach(dot => {
  anime({
  targets: dot,
  rotate: (el, i) => anime.random(90, 360),
  delay: (el, i) => anime.random(0, 500),
  duration: (el, i) => anime.random(250, 750),
  loop: true,
  easing: 'easeInOutSine',
  direction: 'alternate',
  autoplay: true
});
})

duplicateHTML(document.querySelector('#circles'), 20)
  anime({
  targets: '#circles .dot',
  scale: [0, 1.2],
  delay: (el, i) => i*100,
  duration: 250,
  loop: true,
  easing: 'easeInOutSine',
  direction: 'alternate',
});

 anime({
  targets: '#flashes .flash',
  backgroundColor: (el, i) => ['#fff636', '#cb89fc', '#fc3035', '#77ebfd',][i],
  delay: (el, i) => anime.random(50, 100),
  duration: 500,
  loop: true,
  easing: 'easeInOutSine',
  direction: 'alternate',
});

anime({
  targets: '#squares rect',
  translateX: ['-50%', '-50%'],
  translateY: ['-50%', '-50%'],
  rotate: [45, 0, -45],
  delay: (el, i) => 100 * i,
  duration:(el, i) => 750,
  loop: true,
  easing: 'easeInOutSine',
  direction: 'alternate'
})