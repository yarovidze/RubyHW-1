# frozen_string_literal: false

require 'colorize'
require 'display_content'
# class Pet creates a pet for game
class Pet
  attr_reader :name, :life, :age, :mood, :hunger, :sleep, :wc, :study, :poo_poo, :evolution, :minion_phrase, :phrase, :attention_phrase, :emoji

  def initialize(name)
    @name = name
    @life = 3
    @age = 0
    @mood = 20
    @hunger = 0
    @sleep = 0
    @wc = 0
    @study = 0
    @poo_poo = 0
    @evolution = false
    @minion_phrase = ''
    @phrase = ''
    @emoji = ''

    print "
────────▄▀▀═════════════▀▀▄
───────█═══════════════════█
──────█═════════════════════█
─────█═══▄▄▄▄▄▄▄═══▄▄▄▄▄▄▄═══█
────█═══█████████═█████████═══█
────█══██▀────▀█████▀────▀██══█
───██████──█▀█──███──█▀█──██████
───██████──▀▀▀──███──▀▀▀──██████
────█══▀█▄────▄██─██▄────▄█▀══█
────█════▀█████▀───▀█████▀════█
────█═════════════════════════█
────█═════════════════════════█
────█═══════▀▄▄▄▄▄▄▄▄▄▀═══════█
────█═════════════════════════█
───▐▓▓▌═════════════════════▐▓▓▌
───▐▐▓▓▌▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▐▓▓▌▌
───█══▐▓▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄▓▌══█
──█══█═▐▓▓▓▓▓▓▐██▀██▌▓▓▓▓▓▓▌═█══█
──█══█═▐▓▓▓▓▓▓▓▀▀▀▀▀▓▓▓▓▓▓▓▌═█══█
─▄█══█▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌█══█▄
─█████▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌─█████
─██████▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌─██████
──▀█▀█──▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌───█▀█▀
─────────▐▓▓▓▓▓▓▌▐▓▓▓▓▓▓▌
──────────▐▓▓▓▓▌──▐▓▓▓▓▌
─────────▄████▀────▀████▄ ❤
".colorize(:light_yellow)
    to_front("Minion #{name} came to you!", false)
    to_front("#{@name}: BELLO!")
    @emoji = '&#x1F92A;'
  end

  def to_front(text, minion = true, warning = false)
    if minion
      puts text.colorize(:light_yellow)
      @minion_phrase = text
    elsif warning
      @attention_phrase = text
      puts text.colorize(:red)
    else
      @phrase = text
      puts text
    end
  end

  def feed
    to_front("You give #{@name} his favorite food", false)
    to_front(@name + [': BANANAA!', ': BA-NA-NA!', ': POTATO!', ': BABLE!', ': GELATO!'].sample.to_s)
    to_front('', false, true)
    @hunger = -1
    @emoji = '&#x1F924;'
    passed_time
  end

  def go_sleep
    if @wc >= 7 || @hunger >= 7
      to_front('Attention! Minion can not sleep. Something bothers him.', false, true)
      to_front("#{@name}: BULAKA")
      @emoji = '&#x1F914;'
    else
      to_front("You put #{@name} to bed.", false)
      to_front("#{@name}: MUAK MUAK MUAK!")
      @sleep = 0
      @emoji = '&#x1F634;'
      2.times { passed_time }
    end
  end

  def go_wc
    to_front('Minion goes to the toilet', false)
    to_front("#{@name}: PWEDE NA?")
    to_front('', false, true)
    @wc = 0
    @emoji = '&#x1F92B;'
    passed_time
  end

  def walk_check
    if @hunger >= 6
      to_front('Attention! The walk will take a long time. Recommended to feed minion before walk. Input 1 for walk or 2 for feed minion.', false, true)
      walk_choice = gets.chomp.strip
      case walk_choice
      when '1'
        walk
      when '2'
        feed
      else
        to_front('Unknown command. Please input 1 or 2.', false, true)
      end
    else
      walk
    end
  end

  def teach
    to_front('You minion is learning Ruby', false)
    to_front("#{@name}: WOW! BOBMA!")
    if @mood < 4
      @study += 1
    else
      @study += 2
    end
    @emoji = '&#x1F913;'
    passed_time
  end

  def clean_up
    to_front('We cleaned up around', false)
    @poo_poo = 0
    @emoji = '&#x1F644;'
    to_front('')
    passed_time
  end

  def play
    to_front('Enter number of game if you want to play: 1 - Guess Number, 2 - Slot Machine, 3 - Roll The Dice, 4 - exit game list', false)
    game = gets.chomp.strip
    case game
    when '1'
      game1
    when '2'
      game2
    when '3'
      game3
    when '4'
      status
      to_front('', false)
    else
      to_front('Unknown command. Enter number of game.', false)
    end
  end

  def super_skill
    if @evolution
      to_front('All parameters are restored!', false)
      to_front("#{@name}: BEE DO BEE DO BEE DO!")
      @hunger = 0
      @wc = 0
      @sleep = 0
      @mood = 20
      @emoji = '&#x1F92F;'
    else
      to_front('Sorry, but you minion has not evolved yet', false)
      to_front('')
      @emoji = '&#x1F97A;'
    end
  end

  def status
    puts '----------------Your minion status-----------------'.colorize(:cyan)
    puts @name.colorize(:light_yellow)
    puts "Age: #{@age}".colorize(:cyan)
    puts "Life: #{@life}".colorize(:cyan)
    puts "Mood: #{@mood * 5}%".colorize(:cyan)
    puts "Hunger: #{@hunger * 10}%".colorize(:cyan)
    puts "Sleep: #{@sleep * 5}%".colorize(:cyan)
    puts "WC: #{@wc * 10}%".colorize(:cyan)
    puts "Education: level #{@study}".colorize(:cyan)
    puts '---------------------------------------------------'.colorize(:cyan)
  end

  def help
    puts 'List of available commands:'
    puts '1 or help'
    puts '2 or status'
    puts '3 or feed'
    puts '4 or sleep'
    puts '5 or wc'
    puts '6 or walk'
    puts '7 or teach'
    puts '8 or clean'
    puts '9 or play'
    puts '10 or super-skill'
    puts '11 or exit'
  end

  private

  def passed_time
    @age += 1
    @hunger += 1
    @wc += 1
    @sleep += 1
    @mood -= 1

    # evolution
    if !@evolution && @age >= 40 && @study >= 30
      to_front("WOWOWOWOWOWOWOWOW!!!!!! #{@name} evolve into a Super#{@name}!", false)
      @name = "Super#{@name}"
      to_front("#{@name}: BULAKA!")
      @life += 1
      @evolution = true
      @emoji = '&#x1F608;'
    end

    # hunger
    if @hunger >= 8
      to_front('Attention! Feed your minion!', false, true)
      to_front("#{@name}: ME WANT BANANA!")
      @emoji = '&#x1F34C;'
    end
    if @hunger >= 10
      die
      to_front("You did not feed your minion. #{@name} lost one life, #{@life} left", false, true)
      to_front("#{@name}: TATATA BALA TU!")
    end

    # sleep
    if @sleep >= 16
      @mood -= 1
      @emoji = '&#x1F971;'
      to_front('Attention! Minion wants to sleep!', false, true)
    end
    if @sleep >= 18
      @mood -= 3
      @emoji = '&#x1F974;'
      to_front('Attention! Minion wants to sleep! Mood gets worse.', false, true)
    end

    # wc
    if @wc >= 8
      to_front('Attention! Minion wants to go to the toilet!', false, true)
      to_front("#{@name}: STUPA! PEE-PEE!")
      @emoji = '&#x1F629;'
    end
    if @wc >= 10
      to_front('Your minion went to the toilet in jeans', false, true)
      to_front("#{@name}: OOOPS! BI-DO")
      @poo_poo += 1
      @wc = 0
      @emoji = '&#x1F4A9;'
    end

    # mood
    if @mood <= 3
      to_front('Attention! Minion is in no mood. Learning gets harder. Play with him or take for a walk.', false, true)
      to_front("#{@name}: PAPOY..")
      @emoji = '&#x1F61E;'
    end

    # poo-poo
    if @poo_poo > 3
      to_front('Attention! It is too dirty. Please clean around', false, true)
      @mood -= 1
    end
    if @poo_poo > 5
      die
      to_front("#{@name} is sick and lost one life, #{@life} left", false, true)
    end

    # life
    if @life.zero?
      to_front("Minion has no lives left. You lost #{@name}", false, true)
      to_front("#{@name}: POOPAYE...")
      @emoji = '&#x2620;'
      exit
    end

    # parameter limit
    @mood = 0 if @mood.negative?
    @mood = 20 if @mood > 20
    @sleep = 10 if @sleep > 10
  end

  def walk
    to_front("You go for a walk with #{@name}", false)
    to_front("#{@name}: KAMPAI!")
    @wc = 0
    @mood += 5
    @hunger += rand(2..4)
    @emoji = '&#x1F601;'
    passed_time
  end

  def die
    @life -= 1
    @age = 0
    @mood = 20
    @hunger = 0
    @sleep = 0
    @wc = 0
    @study = 0
    @name = @name.delete_prefix('Super') if @evolution
    @evolution = false
    @emoji = '&#x1F631;'
    to_front('', false, true)
  end

  def game1
    to_front("Game 'Guess Number'", false)
    to_front('The minion thought of a number from 1 to 100, guess the number.', false)
    number = rand(1..100)
    input = ''
    until input == 'stop'
      to_front("Input number or 'stop' to exit game:", false)
      input = gets.chomp
      if input.to_i > number
        to_front('Your number is greater.', false)
      elsif input.to_i < number
        to_front('Your number is less.', false)
      else
        to_front("Right! Guess number - #{number}", false)
        to_front("#{@name}: TULALILOO TI AMO!")
        @mood += 4
        @emoji = '&#x1F61D;'
        break
      end
    end
    passed_time
  end

  def game2
    to_front("Game 'Slot Machine'", false)
    to_front('Minion has 30 dollars. One game on a slot machine costs 50 cent.', false)
    win_variant = { '700' => 10, '710' => 20, '720' => 30, '730' => 40, '740' => 50, '750' => 60, '760' => 70, '770' => 80, '777' => 10_000 }
    money = 30
    input = ''
    until input == 'stop'
      to_front("Press ENTER for game or 'stop' to exit game", false)
      input = gets.chomp
      random = rand(700..780).to_s
      if win_variant[random]
        to_front("#{@name} win #{win_variant[random]} dollars.", false)
        to_front("#{@name}: BEE DO BEE DO BEE DO!")
        @mood += 8
        money += win_variant[random]
      elsif money <= 0
        to_front("#{@name} lost all the money", false)
        to_front("#{@name}: SA LA KA!")
        @mood -= 4
        break
      else
        to_front('Minion lost 50 cent.', false)
        money -= 0.5
      end
      to_front("Combination: #{random}. Minion balance is #{money}", false)
    end
    @emoji = '&#x1F911;'
    passed_time
  end

  def game3
    to_front("Game 'Roll the Dice'", false)

    to_front("#{@name} roll the dice", false)
    to_front("#{@name}: HANA, DUL, SAE")

    to_front("First dice = #{a = roll}, second dice = #{b = roll}: sum = #{minions_dices = a + b}. Press ENTER to roll the dice", false)
    gets
    to_front("First dice = #{a = roll}, second dice = #{b = roll}: sum = #{your_dices = a + b}", false)

    if your_dices > minions_dices
      to_front('You win!', false)
      to_front("#{@name}: UNDERWEAR…")
      @emoji = '&#x1F620;'
      @mood -= 1
    else
      to_front('Minion win!', false)
      to_front("#{@name}: KAMPAI!")
      @emoji = '&#x1F973;'
      @mood += 3
    end
    passed_time
  end

  def roll
    rand(1..6)
  end
end

puts 'For colorizing text install gem colorize'
puts '---------------------------------------------------'
puts 'Welcome to the tamagotchi game! Your pet is a minion.'
puts 'Please enter minion\'s name:'
input_name = gets.chomp.strip.capitalize
pet = Pet.new(input_name)
# pet = Pet.new('Stuard')

command = ''
until command == 'exit'
  puts '---------------------------------------------------'
  content = "
<header>
  <span>#{pet.name}</span>
  <span>#{pet.attention_phrase}</span>
</header>
<main>
  <section>
    <ul>
      <li>Life: <strong>#{pet.life}</strong></li>
      <li>Age: <strong>#{pet.age}</strong></li>
      <li>Mood: <strong>#{pet.mood * 5}%</strong></li>
      <li>Hunger: <strong>#{pet.hunger * 10}%</strong></li>
      <li>Sleep: <strong>#{pet.sleep * 5}%</strong></li>
      <li>WC: <strong>#{pet.wc * 10}%</strong></li>
      <li>Study: <strong>#{pet.study}</strong></li>
    </ul>
  </section>

  <article>
    <div>
      <p>#{pet.phrase}</p>
    </div>
    <div>
      <p>#{pet.minion_phrase}</p>
    </div>
  </article>
  <aside>
    <p>#{pet.emoji}</p>
  </aside>
</main>
<footer>
  <p>List of available commands:</p>
  <p> 1 - help, 2 - status, 3 - feed, 4 - sleep, 5 - wc, 6 - walk, 7 - teach, 8 - clean, 9 - play, 10 - super-skill, 11 - exit</p>
</footer>
<script>
  setInterval(()=>{window.location.reload()}, 1000)
</script>
"
  DisplayContent.display_content(content, true, 'page')
  puts 'Please input command or type help:'
  command = gets.chomp.strip
  case command
  when 'help', '1'
    pet.help
  when 'status', '2'
    pet.status
  when 'feed', '3'
    pet.feed
  when 'sleep', '4'
    pet.go_sleep
  when 'wc', '5'
    pet.go_wc
  when 'walk', '6'
    pet.walk_check
  when 'teach', '7'
    pet.teach
  when 'clean', '8'
    pet.clean_up
  when 'play', '9'
    pet.play
  when 'super-skill', '10'
    pet.super_skill
  when 'exit', '11'
    exit
  else
    puts "#{command} unknown command. To get list of commands type help"
  end
end
