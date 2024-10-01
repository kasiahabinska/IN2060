library IEEE; 
use IEEE.STD_LOGIC_1164.all;
  
entity tb_cla_block is   
end entity tb_cla_block;

architecture behavioral of tb_cla_block is 
  component CLA_block is
    port(
        a, b  : in  std_logic_vector(3 downto 0);
        cin   : in  std_logic;
        s     : out std_logic_vector(3 downto 0);
        cout  : out std_logic
    );
  end component;

  signal tb_a, tb_b : std_logic_vector(3 downto 0) := (others => '0');
  signal tb_cin : std_logic := '0';
  signal tb_s : std_logic_vector(3 downto 0);
  signal tb_cout : std_logic;
	  
begin  
  DUT: CLA_block    
  port map(        
    a    => tb_a,   
    b    => tb_b,   
    cin  => tb_cin, 
    s    => tb_s,   
    cout => tb_cout 
  );
  	
  process  
  begin
    -- test 1: zero addition (both operands zero)
    wait for 10 ns;
    tb_a <= "0000";
    tb_b <= "0000";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "0000") report ("test1: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test1: tb_cout feil") severity failure;

    -- test 2: simple addition without carry
    wait for 10 ns;
    tb_a <= "0001";
    tb_b <= "0001";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "0010") report ("test2: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test2: tb_cout feil") severity failure;

    -- test 3: addition with carry propagation
    wait for 10 ns;
    tb_a <= "1111";
    tb_b <= "0001";
    tb_cin <= '0';
    wait for 10 ns;
    assert(tb_s = "0000") report ("test3: tb_s feil") severity failure;
    assert(tb_cout = '1') report ("test3: tb_cout feil") severity failure;

    -- test 4: full carry-in
    wait for 10 ns;
    tb_a <= "1111";
    tb_b <= "1111";
    tb_cin <= '1';
    wait for 10 ns;
    assert(tb_s = "1111") report ("test4: tb_s feil") severity failure;
    assert(tb_cout = '1') report ("test4: tb_cout feil") severity failure;

    -- test 5: random values with carry-in
    wait for 10 ns;
    tb_a <= "0110";
    tb_b <= "0011";
    tb_cin <= '1';
    wait for 10 ns;
    assert(tb_s = "1010") report ("test5: tb_s feil") severity failure;
    assert(tb_cout = '0') report ("test5: tb_cout feil") severity failure;

    report("Ferdig!") severity note;
    std.env.stop;   
  end process;
end architecture behavioral;