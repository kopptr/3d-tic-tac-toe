library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use work.eCLOCK;

entity SRAM_16Bit_512K is
    port(
            iCLK: in std_logic;
            iREAD: in std_logic;
            iWRITE: in std_logic;
            iADDR : in std_logic_vector(17 downto 0);
            iDATA : in std_logic_vector(15 downto 0);
            UB_N : in std_logic;
            LB_N : in std_logic;

            oCLK : OUT STD_LOGIC;
            SRAM_ADDR: OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
            oDATA    : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            SRAM_DQ  : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            SRAM_OE_N: OUT STD_LOGIC;
            SRAM_WE_N: OUT STD_LOGIC;
            SRAM_CE_N: OUT STD_LOGIC;
            SRAM_UB_N: OUT STD_LOGIC;
            SRAM_LB_N: OUT STD_LOGIC
        );
END SRAM_16Bit_512K;

architecture controller of SRAM_16Bit_512k is
    type state_type is (IDLE, CHIP_ON, WRITE_EN, WRITING, READ_EN, READING);
    signal current_state : state_type := IDLE;
    -- Used to register input. High when iREAD, low when iWRITE.
    signal iREAD_H_reg : std_logic;
    signal ADDR_reg : std_logic_vector(17 downto 0);
    signal DATA_reg : std_logic_vector(15 downto 0);
    signal UB_reg : std_logic;
    signal LB_reg : std_logic;
    signal output : stD_logic_vector(15 downto 0);
begin
    CLOCK : eCLOCK
    generic map(count => 4, dc_count => 1)
    port map(
                CLOCK_50MHz => iCLK,
                eCLOCK => oCLK);
    process(iCLK)
    begin
        if rising_edge(iCLK) then
            case current_state is
                when IDLE =>
                    SRAM_OE_N <= '1';
                    SRAM_WE_N <= '1';
                    SRAM_CE_N <= '1';
		    SRAM_DQ <= (others=>'Z');
		    SRAM_ADDR <= (others=>'Z');
                    ADDR_reg <= iADDR;
                    if iREAD = '1' xor iWRITE = '1' then
                        iREAD_H_reg <= iREAD;
                        current_state <= CHIP_ON;
                    end if;

                when CHIP_ON =>
                    SRAM_CE_N <= '0';
                    SRAM_OE_N <= '1';
                    SRAM_WE_N <= '1';
                    SRAM_ADDR <= ADDR_reg;
		    SRAM_DQ <= (others=>'Z');
                    -- Change States
                    if iREAD_H_reg = '1' then
                        current_state <= READ_EN;
                    else -- i_READ_H_reg = '0'
                        current_state <= WRITE_EN;
                    end if;

                when WRITE_EN =>
                    SRAM_DQ <= iDATA;
                    SRAM_WE_N <= '0';
                    SRAM_OE_N <= '1';
                    current_state <= WRITING;
                    UB_reg <= UB_N;
                    LB_reg <= LB_N;

                when WRITING =>
                    SRAM_WE_N <= '1';
                    SRAM_DQ <= iDATA;
                    current_state <= IDLE;

                when READ_EN =>
                    SRAM_DQ <= (others=>'Z');
                    SRAM_WE_N <= '1';
                    SRAM_OE_N <= '0';
                    current_state <= READING;

                    UB_reg <= UB_N;
                    LB_reg <= LB_N;

                when READING =>
                    output <= SRAM_DQ;
                    current_state <= IDLE;
            end case;
        end if;
    end process;
    SRAM_UB_N <= UB_reg;
    SRAM_LB_N <= LB_reg;
    oDATA <= output;
end architecture controller;
