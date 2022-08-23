package main.Pistas;

import java.util.Random;

public class GuessNumber {
    private static int number;
    private static int max = 1000;
    private static int min = 0;
    private static int tries = 10;
    private static GuessNumber guessNumber;
    private GuessNumber() {}

    //Patron sigleton
    public static  GuessNumber getInstance(){
        if(guessNumber == null){
            guessNumber = new GuessNumber();
            createNumber();
        }
        return guessNumber;
    }

    public String checkGame(int guessNumber){
        boolean guess = compareNumber(guessNumber);
        boolean triesLeft = triesLeft();

        if (guess){ return "Ganaste el juego flaco!! \uD83E\uDD73 \uD83E\uDD73";}

        if (triesLeft){return giveClue(guessNumber);}

        return "Perdiste el juego flaco \uD83E\uDD72";
    }

    public void resetAll(){
        createNumber();
        resetTries();
    }

    private static void createNumber(){
        Random random = new Random(); //instance of random class
        number = random.nextInt(max - min) + min;
    }

    private void resetTries(){
        tries = 10;
    }

    private boolean compareNumber(int guessNumber){
        return number == guessNumber;
    }

    private boolean triesLeft(){
        return --tries >= 1;
    }

    private String giveClue(int guessNumber){
        // Create variables
        int difference = guessNumber - number;
        int positiveDifference = Math.abs(difference);
        boolean isPositive = difference < 0;
        // Check differences
        if( positiveDifference > 1000){
            return isPositive ? "Estas bien lejos flaco, ve con todo arriba" : "Estas bien lejos flaco, ve con todo abajo";
        }
        if( positiveDifference >= 500){
            return isPositive ? "Estas lejos flaco, ve bastante arriba" : "Estas lejos flaco, ve bastante abajo";
        }
        if( positiveDifference >= 250){
            return isPositive ? "Estas algo lejos flaco, ve mas arriba" : "Estas algo lejos flaco, ve mas abajo";
        }
        if( positiveDifference >= 100){
            return isPositive ? "Estas relativamente cerca flaco, ve algo arriba" : "Estas relativamente cerca flaco, ve algo abajo";
        }
        if( positiveDifference >= 50){
            return isPositive ? "Estas a no mucho flaco, ve algo arriba" : "Estas a no mucho flaco, ve algo abajo";
        }
        if( positiveDifference >= 25){
            return isPositive ? "Ya estas cerca flaco, ve algo arriba" : "Ya estas cerca flaco, ve algo abajo";
        }
        if( positiveDifference >= 10){
            return isPositive ? "Estas cerquita, ve un poco arriba" : "Estas cerquita, ve un poco abajo";
        }
        if( positiveDifference >= 1){
            return isPositive ? "Ya casi, ve poquito arriba" : "Ya casi, ve poquito abajo";
        }
        return "No estas perdido, es que no estas en el camino flaco";
    }

    public static int getTries() {
        return tries;
    }

    public static int getNumber() {
        return number;
    }

    public void surrender(){
        tries = 0;
    }

}
