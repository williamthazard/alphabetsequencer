---a sequencer
s = sequins
a = s{1, 1, 1, 4} -- voice 1 pitch
b = s{1/4, 1/4, 1/2} -- voice 1 timing
c = s{4, 1, 6, 1} -- voice 2 pitch
d = s{1/2, 1/4, 1/4} -- voice 2 timing
e = s{4, 4, 6, 4, 6} -- just friends voice 1 pitch
f = s{1/2, 1/2, 1/2, 1} -- just friends voice 1 timing
g = s{2, 3, 2} -- just friends voice 1 level
h = s{4, 6, 4, 6} -- just friends voice 2 pitch
i = s{1/4, 1} -- just friends voice 2 timing
j = s{2, 2, 3} -- just friends voice 2 level
k = s{6, 6, 4} -- just friends voice 3 pitch
l = s{1/2, 1/4, 1/2} -- just friends voice 3 timing
m = s{2, 3, 2, 2} -- just friends voice 3 level
x = s{4, 6, 1, 4} -- w/syn pitch
y = s{2, 1, 2} -- w/syn timing
z = s{2, 2, 3} -- w/syn level
function init()
  input[1].mode('clock')
  bpm = clock.tempo  
  ii.jf.mode(1)
  ii.jf.run_mode(1)
  ii.jf.tick(bpm)
  ii.wsyn.ar_mode(1)
  ii.wsyn.voices(4)
  coro_id = clock.run(notes_event)
          clock.run(other_event)
          clock.run(jfa_event)
          clock.run(jfb_event)
          clock.run(jfc_event)
          clock.run(with_event)
end
function notes_event()
  while true do
    clock.sync(b())
    output[1].volts = a()/12
    output[1].slew = .1
    output[2].action = ar(1, 1, 5, 'lin')
    output[2]()
  end
end
function other_event()
  while true do
    clock.sync(d())
    output[3].volts = c()/12
    output[3].slew = .1
    output[4].action = ar(1, 1, 5, 'lin')
    output[4]()
  end
end
function jfa_event()
  while true do
    clock.sync(f())
    ii.jf.play_note(e()/12, g())
  end
end
function jfb_event()
  while true do
    clock.sync(i())
    ii.jf.play_note(h()/12, j())
  end  
end
function jfc_event()
  while true do
    clock.sync(l())
    ii.jf.play_note(k()/12, m())
  end
end
function with_event()
  while true do
    clock.sync(y())
    ii.wsyn.play_note(x()/12, z())
  end
end