library IEEE; 
use IEEE.STD_LOGIC_1164.all;
  
entity tb_cla_top is   
end entity tb_cla_top;

architecture behavioral of tb_cla_top is 
  component CLA_top is
    generic(
    width : positive := 32
    );
    port(
        a, b  : in  std_logic_vector(width-1 downto 0);
        cin   : in  std_logic;
        s   : out std_logic_vector(width-1 downto 0);
        cout  : out std_logic
    );
  end component;

  signal tb_a, tb_b : std_logic_vector(31 downto 0) := (others => '0');
  signal tb_cin : std_logic := '0';
  signal tb_s : std_logic_vector(31 downto 0);
  signal tb_cout : std_logic;
	  
begin  
  DUT: CLA_top   
  port map(        
    a    => tb_a,   
    b    => tb_b,   
    cin  => tb_cin, 
    s  => tb_s,   
    cout => tb_cout 
  );
  	
  process  
  begin
    wait for 10 ns;
    tb_a <= "00000000000000000000000000000000";
    tb_b <= "00000000000000000000000000000000";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "00000000000000000000000000000000") report ("test1: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test1: tb_cout feil") severity failure;

    tb_a <= "00000000000000000000000000000000";
    tb_b <= "00000000000000000000000000000001";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "00000000000000000000000000000001") report ("test2: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test2: tb_cout feil") severity failure;

    tb_a <= "00000000000000000000000000000001";
    tb_b <= "00000000000000000000000000000001";
    tb_cin <= '1';
    wait for 10 ns;
    assert(tb_s = "00000000000000000000000000000011") report ("test3: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test3: tb_cout feil") severity failure;

    tb_a <= "11111111111111111111111111111111";
    tb_b <= "00000000000000000000000000000001";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "00000000000000000000000000000000") report ("test4: tb_s feil") severity failure;
    assert(tb_cout = '1') report ("test4: tb_cout feil") severity failure;

    tb_a <= "11111111111111111111111111111111";
    tb_b <= "11111111111111111111111111111111";
    tb_cin <= '1';
    wait for 10 ns;
    assert(tb_s = "11111111111111111111111111111111") report ("test5: tb_s feil") severity failure;
    assert(tb_cout = '1') report ("test5: tb_cout feil") severity failure;

    tb_a <= "10000000000000000000000000000000";
    tb_b <= "10000000000000000000000000000000";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "00000000000000000000000000000000") report ("test6: tb_s feil") severity failure;
    assert(tb_cout = '1') report ("test6: tb_cout feil") severity failure;

    tb_a <= "01010101010101010101010101010101";
    tb_b <= "00110011001100110011001100110011";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "10000110000001100110100001110111") report ("test7: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test7: tb_cout feil") severity failure;

    tb_a <= "11111111111111111111111111110000";
    tb_b <= "00000000000000000000000000001111";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "11111111111111111111111111111111") report ("test8: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test8: tb_cout feil") severity failure;


    tb_a <= "11111111111111111111111111111111";
    tb_b <= "11111111111111111111111111111111";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "11111111111111111111111111111110") report ("test9: tb_cout feil") severity failure;
    assert(tb_cout = '1') report ("test9: tb_cout feil") severity failure;

    tb_a <= "00000000000000000000000000000001";
    tb_b <= "00000000000000000000000000000001";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "00000000000000000000000000000010") report ("test10: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test10: tb_cout feil") severity failure;

    report("Ferdig!") severity note;
    std.env.stop;   
  end process;
end architecture behavioral;