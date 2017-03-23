class Menu

  def self.menu(option)

    message = ''

    case option
           when 0
             message = message+"\n           Connection to Server established. Welcome to:"
             message = message+"\n      ________________________________________________________"
             message = message+"\n     /                                                        \\"
             message = message+"\n     |                __   _______  _  __                     |"
             message = message+"\n     |                \\ \\ / /  __ \\| |/ /                     |"
             message = message+"\n     |        ______   \\ V /| |  | | ' /   ______             |"
             message = message+"\n     |       |______|   > < | |  | |  <   |______|            |"
             message = message+"\n     |                 / . \\| |__| | . \\                      |"
             message = message+"\n     |    ______      /_/ \\_\\_____/|_|\\_\\_                    |"
             message = message+"\n     |  / ____(_)               | |     | |                   |"
             message = message+"\n     | | (___  _ _ __ ___  _   _| | __ _| |_ ___  _ __        |"
             message = message+"\n     |  \\___ \\| | '_ ` _ \\| | | | |/ _` | __/ _ \\| '__|       |"
             message = message+"\n     |  ____) | | | | | | | |_| | | (_| | || (_) | |          |"
             message = message+"\n     | |_____/|_|_| |_| |_|\\__,_|_|\\__,_|\\__\\___/|_|          |"
             message = message+"\n     |                                                        |"
             message = message+"\n     |                                                        |"
             message = message+"\n     |                   Press ENTER to continue              |"
             message = message+"\n     |                 ---------------------------            |"
             message = message+"\n     |  2016/2017                                             |"
             message = message+"\n     \\________________________________________________________/"
             message = message+"\n"

                  #
                  #                __   _______  _  __
                  #                \ \ / /  __ \| |/ /
                  #        ______   \ V /| |  | | ' /   ______
                  #       |______|   > < | |  | |  <   |______|
                  #                 / . \| |__| | . \
                  #    ______      /_/ \_\_____/|_|\_\_
                  #  / ____(_)               | |     | |             font: Big
                  # | (___  _ _ __ ___  _   _| | __ _| |_ ___  _ __
                  #  \___ \| | '_ ` _ \| | | | |/ _` | __/ _ \| '__|
                  #  ____) | | | | | | | |_| | | (_| | || (_) | |
                  # |_____/|_|_| |_| |_|\__,_|_|\__,_|\__\___/|_|
                  #

           when 1
             message = message+"\n      ______________MAIN MENU_____________"
             message = message+"\n     /    |                               \\"
             message = message+"\n     | Options:                            |"
             message = message+"\n     |----------                           |"
             message = message+"\n     |    |                        EngWeb  |"
             message = message+"\n     |----|--------------------------------|"
             message = message+"\n     | 1  | List all Clients.              |"
             message = message+"\n     |----|--------------------------------|"
             message = message+"\n     | 2  | List a Client's readings.      |"
             message = message+"\n     |----|--------------------------------|"
             message = message+"\n     | 3  | Simulate Temperature Sensor.   |"
             message = message+"\n     |----|--------------------------------|"
             message = message+"\n     | 4  | Simulate Acoustic Sensor.      |"
             message = message+"\n     |----|--------------------------------|"
             message = message+"\n     | 5  | Close connection.              |"
             message = message+"\n     |----|--------------------------------|"
             message = message+"\n     \\_____________________________________/"

         end

    return message
  end

  def self.list(title, listing)
    message =         "\n  _________________________________________________________"
    message = message+"\n / "
    message = message+"\n"+title
    message = message+"\n \\_________________________________________________________"
    message = message+"\n"+listing
    return message
  end



end

#puts(Menu.menu(0))