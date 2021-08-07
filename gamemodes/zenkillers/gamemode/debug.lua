-- Debugging functions

function print_swep_table()
   PrintTable(weapons.GetList())
end

concommand.Add("zk_print_swep_table", print_swep_table)
