package uk.co.zutty.ld24
{
    public class Robot extends Mob {

        [Embed(source = 'assets/robot2.png')]
        public static const ROBOT_IMAGE:Class;

        public function Robot() {
            super(ROBOT_IMAGE, 2, FACTION_ENEMY, 1, 8);
        }
    }
}