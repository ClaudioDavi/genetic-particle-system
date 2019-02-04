# Genetic Particle System

A Prey and Predator simulation with genetic algorithms powered by Processing and Java.

!(DEMO 1)[demo_1.gif]

### Introduction

Due to my recent interest in genetic algorithms, I decided to create my own take on the famous algorithm Game of Life from John Conway.

His idea for generating a life-like pattern for life followed four simple rules

1. For a space that is 'populated':
   1. Each cell with one or no neighbors dies, as if by solitude.
   1. Each cell with four or more neighbors dies, as if by overpopulation.
   1. Each cell with two or three neighbors survives.
2. For a space that is 'empty' or 'unpopulated'
   1. Each cell with three neighbors becomes populated.

Those rules alone were capable of creating very interesting patterns as seen in the gif below taken from !(Wikipedia)[https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life]. If you want to know more about the original game of life (It's a very interesting read). Please follow the link.

!(Game of Life)[game_of_life.gif]

### Life Rules

For my take on the game of life I created a few rules:

1. Default Rules
   1. If you touch another 'life form' the bigger one survives
   1. If you see someone bigger than you, you run away. (Prey Behaviour)
   1. If you see someone smaller than you, you hunt. (Predator Behaviour)
1. Game Rules
   1. If there are only 5 life forms available, a new generations is born.
   1. If More than 2000 cicles were complete, a new generation is born.
   1. If you touch the wall more than 50 times you die. (Preventing wall exploits)
1. Generation Rules
   1. Each generation is created from the most fit parents chosen using a monte carlo approach.
   1. The fitness is calculated using the following:
      - Each cicle alive wins 2 points
      - Each action taken wins 1 Point (Follow or Run)
      - F = (Cicle + Action)/10
   1. Each parent has 50% chance of spreading one of its genes for every gene in the pool
   1. Each life form has it's own attributes that can be inherited including: size, acceleration, force, velocity, awareness distance and so on.

!(DEMO 2)[demo_2.gif]

### Next Steps:

- Clean the code (There is a lot of unused code in there).
- Improve readbility.
- Create more complex behaviours.
- Use reinforcement learning.
