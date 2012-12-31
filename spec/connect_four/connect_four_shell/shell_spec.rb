require 'spec_helper'

module ConnectFour
  module ConnectFourShell
    DummySettings = Struct.new(:difficulty, :ai_player, :save_method, :board_size, :cells_to_win)

    describe Shell do

      let(:shell) do
        settings = DummySettings.new(3, :second, :file, 10, 4)
        shell = ConnectFour::ConnectFourShell::Shell.new(settings)
        shell.invoke('difficulty 1')
        shell
      end

      describe "#invoke" do
        it "returns 'Command is not recognized' message when incorrect command si entered" do
          shell.invoke('some_random_command with arguments').should eq 'Command is not recognized'
        end

        it "returns 'Too few command parameters' when calling command without required argument" do
          shell.invoke('load-game').should eq 'Too few command parameters'
        end

        it "returns 'Too many command parameters' when calling command with extra parameters" do
          shell.invoke('ai-player some random arguments here').should eq 'Too many command parameters'
        end

        describe "stop-game" do
          it "disallows game stopping if the game isn't started" do
            shell.invoke('stop-game').should eq 'Game is already stopped'
          end
        end

        describe "move" do
          it "disallows move when game is not started" do
            shell.invoke('move 3').should match /first start the game/
          end

          it "disallows move outside the bounds of the board or with other incorrect input" do
            shell.invoke('board-size 10')
            shell.invoke('start-game')
            shell.invoke('move 12').should match /invalid/
            shell.invoke('move -1').should match /invalid/
            shell.invoke('move some_random_text').should match /invalid/
          end

          it "changes the board after move" do
            shell.invoke('board-size 3')
            shell.invoke('ai-player 2')
            shell.invoke('start-game')
            shell.invoke('move 3').should match /. . .\n . . .\n . . X/
          end
        end

        describe "ai-player" do
          it "reads the set value" do
            shell.invoke('ai-player 1')
            shell.invoke('ai-player').should match /first/
          end

          it "should not validates incorrect player's number" do
            shell.invoke('ai-player 123').should match /Incorrect/
          end
        end

        describe "difficulty" do
          it "reads the set value" do
            shell.invoke('difficulty 3')
            shell.invoke('difficulty').should match /3/
          end
        end

        describe "save-method" do
          it "reads the set value" do
            shell.invoke('save-method file')
            shell.invoke('save-method').should match /file/
          end
        end

        describe "board-size" do
          it "reads the set value" do
            shell.invoke('board-size 3')
            shell.invoke('board-size').should match /3/
          end
        end

        describe "cells-to-win" do
          it "reads the set value" do
            shell.invoke('cells-to-win 3')
            shell.invoke('cells-to-win').should match /3/
          end
        end

        describe "exit" do
          it "calls handler on exit command" do
            is_exit_called = false
            shell.invoke('exit')
            shell.on_exit { is_exit_called = true  }
            is_exit_called.should eq false
            shell.invoke('exit')
            is_exit_called.should eq true
          end
        end
      end
    end
  end
end