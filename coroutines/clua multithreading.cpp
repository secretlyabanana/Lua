static int Delay(lua_State *L) {
	Sleep(lua_tonumber(L, 1));
	return 0;
};

int main() {
	lua_State *L = luaL_newstate();
	lua_register(L, "Delay", Delay);
	
	return 0;
};

//by secret6timb1
