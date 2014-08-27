$('.champion-name').on 'mouseenter', 'a', ->
  $(this).parent().parent().animate
    height: "350px"

$('.champion-name').on 'mouseleave', 'a', ->
  $(this).parent().parent().animate
    height: "175px"    