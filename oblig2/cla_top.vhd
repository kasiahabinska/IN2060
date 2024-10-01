library IEEE; 
  use IEEE.STD_LOGIC_1164.all;

entity CLA_top is   
  generic(
    width : positive := 32
  );
  port(
    a, b  : in  std_logic_vector(width-1 downto 0);
    cin   : in  std_logic;
    s   : out std_logic_vector(width-1 downto 0);
    cout  : out std_logic
  );
end entity CLA_top;

architecture mixed of CLA_top is
    component CLA_block
    port(
        a, b  : in  std_logic_vector(3 downto 0);
        cin   : in  std_logic;
        s   : out std_logic_vector(3 downto 0);
        cout  : out std_logic
    );
    end component;

    signal c : std_logic_vector(width/4 - 1 downto 0);

    begin
    CLA1 : CLA_block
    port map(
        a => a(3 downto 0),
        b => b(3 downto 0),
        cin => cin,
        s => s(3 downto 0),
        cout => c(0)
    );
    CLA2 : CLA_block
    port map(
        a => a(7 downto 4),
        b => b(7 downto 4),
        cin => c(0),
        s => s(7 downto 4),
        cout => c(1)
    );
    CLA3 : CLA_block
    port map(
        a => a(11 downto 8),
        b => b(11 downto 8),
        cin => c(1),
        s => s(11 downto 8),
        cout => c(2)
    );
    CLA4 : CLA_block
    port map(
        a => a(15 downto 12),
        b => b(15 downto 12),
        cin => c(2),
        s => s(15 downto 12),
        cout => c(3)
    );
    CLA5 : CLA_block
    port map(
        a => a(19 downto 16),
        b => b(19 downto 16),
        cin => c(3),
        s => s(19 downto 16),
        cout => c(4)
    );
    CLA6 : CLA_block
    port map(
        a => a(23 downto 20),
        b => b(23 downto 20),
        cin => c(4),
        s => s(23 downto 20),
        cout => c(5)
    );
    CLA7 : CLA_block
    port map(
        a => a(27 downto 24),
        b => b(27 downto 24),
        cin => c(5),
        s => s(27 downto 24),
        cout => c(6)
    );
    CLA8 : CLA_block
    port map(
        a => a(31 downto 28),
        b => b(31 downto 28),
        cin => c(6),
        s => s(31 downto 28),
        cout => c(7)
    );
    cout <= c(width/4 - 1);

end architecture mixed;


