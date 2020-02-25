local unpack = unpack or table.unpack

sent_att = {}
sent_att.__index = sent_att
sent_att.settings = {}
--bal_move
--eq_move
--eq_special
--no_bal = {}
sent_att.settings.stand = false
sent_att.settings.lightpipes = false
sent_att.settings.pipes = {}
-- target
sent_att.settings.target_limb = "nothing"
-- dir
-- bal_list = {}
-- bal_str
sent_att.settings.sep = "|||"
sent_att.settings.my_spear = my_spear or "spear"
sent_att.settings.my_axe = my_axe or "handaxe"
sent_att.refs = {}
sent_att.refs.basilisk_eye = {
	confusion = "gaze",
	paralysis = "gaze",
	stupidity = "glare",
	impatience = "glare",
}

sent_att.refs.ents = {
	butterfly = true,
	raven = true,
	fox = true,
	badger = true,
	lemming = true,
	wolf = true,
}
	
sent_att.refs.bal_moves = {
	axe = true,
	aim = true,
	trip = true,
	grab = true,
	rive = true,
	thrust = true,
	spin = true,
	brace = true,
	rivestrike = true,
	ensnare = true,
	lacerate = true,
	scythe = true,
	rattle = true,
	truss = true,
	skullbash = true,
	gouge = true,
	impale = true,
	drag = true,
	wrench = true,
	doublestrike = true,
	extirpate = true,
	ambush = true,
	burrow = true,
	dig = true,
	dismember = true,
	fitness = true,
	fly = true,
	leap = true,
	maul = true,
	might = true,
	pound = true,
	shred = true,
	snap = true,
	stampede = true,
	trumpet = true,
	yank = true,
	tumble = true,
}
	
sent_att.refs.eq_moves = {
	eye = true,
	freeze = true,
	melody = true,
	negate = true,
	petrify = true,
	shield = true,
	web = true,
}
	
sent_att.refs.eq_moves_sp = {
	howl = true,
	contemplate = true,
	summon = true,
}

function sent_att:new()
	local new_att = {}
	setmetatable(new_att,self)
	new_att.settings = {}
	setmetatable(new_att.settings, {__index = self.settings})
	new_att.settings.no_bal = {}
	return new_att
end

function sent_att:target(name)
	self.settings.target = name
	return self.settings.target
end
	
function sent_att:axe(venom, limb)
	local bal_list = {}
	if limb and limb ~= self.settings.target_limb then
		table.insert(bal_list, string.format("target %s", limb))
	end
	if venom then
		table.insert(bal_list, string.format("wipe %s", self.settings.my_axe))
		table.insert(bal_list, string.format("envenom %s with %s", self.settings.my_axe, venom))
	end
	table.insert(bal_list,string.format("throw %s at %s", self.settings.my_axe, self.settings.target))
	self.bal_str = table.concat(bal_list, self.settings.sep)
	return self.bal_str
end
	
function sent_att:aim(dir, venom, limb)
	local bal_list = {}
	if not dir then
		error("Need a direction for LoS - sent_att:aim")
		return
	end
	if limb and limb ~= self.settings.target_limb then
		table.insert(bal_list, string.format("target %s", limb))
	end
	if venom then
		table.insert(bal_list, string.format("wipe %s", self.settings.my_axe))
		table.insert(bal_list, string.format("envenom %s with %s", self.settings.my_axe, venom))
	end
	table.insert(bal_list, string.format("throw %s %s at %s", self.settings.my_axe, dir, self.settings.target))
	self.bal_str = table.concat(bal_list, self.settings.sep)
	return self.bal_str
end	
	
function sent_att:trip(side)
	if side ~= "left" and side ~= "right" then
		error("sent_att:trip requires left or right as argument")
		return
	end
	self.bal_str = string.format("trip %s %s", self.settings.target, side)
	return self.bal_str
end
	
function sent_att:grab(dir)
	if type(dir) ~= "string" then
		error("sent_att:grab needs a direction")
	end
	self.bal_str = string.format("bthrow axe at %s %s", self.settings.target, dir)
	return self.bal_str
end
	
function sent_att:rive()
	self.bal_str = string.format("rive %s", self.settings.target)
	return self.bal_str
end
	
function sent_att:thrust(venom, limb)
	local bal_list = {}
	table.insert(bal_list, string.format("thrust %s", self.settings.target))
	if venom then
		table.insert(bal_list, venom)
	end
	if limb and limb~="nothing" then
		table.insert(bal_list, limb)
	end
	self.bal_str = table.concat(bal_list, " ")
	return self.bal_str
end
	
	function sent_att:spin(ven1, ven2, ven3)
		local bal_list = {}
		table.insert(bal_list, string.format("wipe %s", self.settings.my_spear))
		table.insert(bal_list, string.format("envenom %s with %s", self.settings.my_spear, ven1))
		table.insert(bal_list, string.format("envenom %s with %s", self.settings.my_spear, ven2))
		table.insert(bal_list, string.format("envenom %s with %s", self.settings.my_spear, ven3))
		table.insert(bal_list, "spin spear")
		self.bal_str = table.concat(bal_list, self.settings.my_spearsep)
		return self.bal_str
	end
	
	function sent_att:brace()
		self.bal_str = "brace spear"
		return self.bal_str
	end
	
	function sent_att:rivestrike(venom, limb)
		local bal_list = {}
		table.insert(bal_list, string.format("rivestrike %s", self.settings.target))
		if limb and limb~="nothing" then
			table.insert(bal_list, limb)
		end
		if venom then
			table.insert(bal_list, venom)
		end
		self.bal_str = table.concat(bal_list, " ")
    return self.bal_str
	end
	
	function sent_att:ensnare()
		self.bal_str = string.format("ensnare %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:lacerate(venom, limb)
		local bal_list = {}
		table.insert(bal_list, string.format("lacerate %s", self.settings.target))
		if limb and limb~="nothing" then
			table.insert(bal_list, limb)
		end
		if venom then
			table.insert(bal_list, venom)
		end
		self.bal_str = table.concat(bal_list, " ")
		return self.bal_str
	end
	
	function sent_att:scythe()
		self.bal_str = string.format("scythe %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:rattle ()
		self.bal_str = string.format("rattle %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:truss()
		local bal_list = {}
		table.insert(bal_list, "outr rope")
		table.insert(bal_list, string.format("truss %s", self.settings.target))
		self.bal_str = table.concat(bal_list, self.settings.sep)
		return self.bal_str
	end
	
	function sent_att:skullbash()
		self.bal_str = string.format("skullbash %s", self.settings.target)
		return bal_str
	end
	
	function sent_att:gouge(venom, limb)
		local bal_list = {}
		table.insert(bal_list, string.format("gouge %s", self.settings.target))
		if limb and limb~="nothing" then
			table.insert(bal_list, limb)
		end
		if venom then
			table.insert(bal_list, venom)
		end
		self.bal_str = table.concat(bal_list, " ")
		return self.bal_str
	end	

	function sent_att:impale()
		self.bal_str = string.format("impale %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:drag(dir)
		self.bal_str = string.format("drag %s", dir)
		return self.bal_str
	end
	
	function sent_att:wrench()
		self.bal_str = "wrench"
		return self.bal_str
	end
	
	function sent_att:doublestrike(venom, limb)
		local bal_list = {}
		table.insert(bal_list, string.format("doublestrike %s", self.settings.target))
		if limb and limb~="nothing" then
			table.insert(bal_list, limb)
		end
    if venom then
			table.insert(bal_list, venom)
		end
		self.bal_str = table.concat(bal_list, " ")
		return self.bal_str
	end
	
	function sent_att:extirpate()
		self.bal_str = string.format("extirpate %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:eye(aff)
		if not self.refs.basilisk_eye[aff] then
			error("Affliction not available through a basilisk eye power")
			return
		end
		self.eq_str = string.format("%s %s %s", self.refs.basilisk_eye[aff], self.settings.target, aff)
		return self.eq_str
	end
	
	function sent_att:ambush()
		self.bal_str = string.format("ambush %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:burrow(dir)
		dir = dir or "below"
		self.bal_str = string.format("burrow %s", dir)
		return self.bal_str
	end
	
	function sent_att:dig()
		self.bal_str = "dig"
		return self.bal_str
	end
	
	function sent_att:dismember()
		self.bal_str = string.format("dismember %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:fitness()
		self.bal_str = "fitness"
		return self.bal_str
	end
	
	function sent_att:fly()
		self.bal_str = "fly"
		return self.bal_str
	end
	
	function sent_att:howl()
		self.eq_str = string.format("howl %s", self.settings.target)
		return self.eq_str
	end
	
	function sent_att:freeze(ground)
		if not ground then
			self.eq_str = string.format("freeze %s", self.settings.target)
		else
			self.eq_str = "freeze ground"
		end
		return self.eq_str
	end
	
	function sent_att:leap(dir)
		self.bal_str = string.format("leap %s", dir)
		return self.bal_str
	end
	
	function sent_att:maul(limb)
		local bal_list = {}
		table.insert(bal_list, string.format("maul %s", self.settings.target))
		if limb and limb~="nothing" then
			table.insert(bal_list, limb)
		end
		self.bal_str = table.concat(bal_list, " ")
		return self.bal_str
	end
	
	function sent_att:melody()
		self.eq_str = "sing melody"
		return self.eq_str
	end
	
	function sent_att:might()
		self.bal_str = "might"
		return self.bal_str
	end
	
	function sent_att:negate()
		self.eq_str = string.format("negate %s", self.settings.target)
		return self.eq_str
	end
	
	function sent_att:petrify()
		self.eq_str = string.format("petrify %s", self.settings.target)
		return self.eq_str
	end
	
	function sent_att:pound()
		self.bal_str = string.format("pound %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:shred()
		self.bal_str = string.format("shred %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:snap()
		self.bal_str = string.format("snap %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:stampede()
		self.bal_str = string.format("stampede %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:trumpet()
		self.bal_str = string.format("trumpet %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:yank()
		self.bal_str = string.format("yank %s", self.settings.target)
		return self.bal_str
	end
	
	function sent_att:summon(animal)
		self.eq_str = string.format("summon %s", animal)
		self.eq_special = "summon"
		self.eq_special_args = {animal}
		return self.eq_str
	end
	
	function sent_att:tumble(dir)
		if not dir then
			error("sent_att:tumble need a valid direction!")
			return
		end
		self.bal_str = string.format("tumble %s", dir)
		return self.bal_str
	end
	
	function sent_att:shield()
		self.eq_str = "touch shield"
		return self.eq_str
	end
	
	function sent_att:contemplate()
		self.eq_str = string.format("contemplate %s", self.settings.target)
		return self.eq_str
	end
	
	function sent_att:web()
		self.eq_str = string.format("touch web %s", self.settings.target)
		return self.eq_str
	end
	
	function sent_att:morph(animal)
		if type(animal) ~= "string" then
			error("sent_att:morph needs a valid animal argument")
			return
		end
		self.to_morph = animal
	end
	
	function sent_att:enr(ent)
		if not ent then
			self.settings.enrage = nil
		else
			if not self.refs.ents[ent] then
				error(tostring(ent).." is not a valid animal to enrage!")
				return
			else
				self.settings.enrage = ent
			end
		end
		return self.settings.enrage
	end
	
	function sent_att:diss(ent)
		if not ent then
			self.settings.dismiss = nil
		else
			if not self.refs.ents[ent] then
				error(tostring(ent).." is not a valid animal to enrage!")
				return
			else
				self.settings.dismiss = ent
			end
		end
		return self.settings.dismiss
	end
	
	function sent_att:parry(limb)
		if type(limb) ~= "string" then
			error("sent_att:parry needs a limb specified")
			return
		end
		self.to_parry = limb
	end
	
	
	function sent_att:act(move, args)
		if self.refs.bal_moves[move] then
			self.bal_move = move
			self.bal_args = args
			self.eq_move = false
		elseif self.refs.eq_moves[move] then
			self.bal_move = false
			self.eq_move = move
			self.eq_args = args
			self.eq_special = false
		elseif self.refs.eq_moves_sp[move] then
			self.eq_move = false
			self.eq_special = move
			self.eq_special_args = args
		end
	end
	
	function sent_att:no_bal(move)
	  table.insert(self.settings.no_bal, move)
	end
	
	function sent_att:stand(negate, args)
		if not negate then
			self.settings.stand = true
		else
			self.settings.stand = false
		end
	end
	
	function sent_att:setpipes(pipelist)
		if type(pipelist) ~= "table" or #pipelist == 0 then
			error("pipe list needs to be an array of pipe ids")
			return
		end
		self.settings.pipes = pipelist
		return self.settings.pipes
	end
	
	function sent_att:lightpipes(negate)
		if not negate then
			self.settings.lightpipes = true
		else
			self.settings.lightpipes = false
		end
	end
	
	function sent_att:commit()
		local do_first = {}
    
		if self.to_morph then
			table.insert(do_first, string.format("morph %s", self.to_morph))
		end
		if self.settings.stand then
			table.insert(do_first, "stand")
		end
    
		if self.settings.lightpipes and #self.settings.pipes &gt; 0 then
			for _,v in ipairs(self.settings.pipes) do
				table.insert(do_first, string.format("light %s", v))
			end
		end
		if self.to_parry then
			table.insert(do_first, string.format("parry %s", self.to_parry))
		end
		local actions = {}
		local actions_free = {}
		if #do_first &gt; 0 then
			table.insert(actions_free, table.concat(do_first,self.settings.sep))
		end
		if #self.settings.no_bal &gt; 0 then
			table.insert(actions_free, table.concat(self.settings.no_bal, self.settings.sep))
		end
		if #actions_free &gt; 0 then
			table.insert(actions, table.concat(actions_free, self.settings.sep))
		end
		if self.settings.enrage then
			table.insert(actions, string.format("enrage %s %s", self.settings.enrage, self.settings.target))
		end
		if self.settings.dismiss and self.bal_move~="impale" and self.bal_move~="wrench" and not self.eq_move and (not self.eq_special or self.eq_special=="summon") then
			table.insert(actions, string.format("dismiss %s", self.settings.dismiss))
		end
   -- cecho("&lt;red:green&gt;stopped")
		if self.bal_move then
			if self.bal_args then
				table.insert(actions, self[self.bal_move](self, unpack(self.bal_args)))
			else
				table.insert(actions, self[self.bal_move](self))
			end
		end
    
		if self.eq_move then
			if self.eq_args then
				table.insert(actions, self[self.eq_move](self, unpack(self.eq_args)))
			else
				table.insert(actions, self[self.eq_move](self))
			end
		end
		if self.eq_special then
			if self.eq_special_args then
				table.insert(actions, self[self.eq_special](self,unpack(self.eq_special_args)))
			else
				table.insert(actions, self[self.eq_special](self))
			end
		end
		if self.bal_special then
			if self.bal_special_args then
				table.insert(actions, self[self.bal_special](self, unpack(self.bal_special_args)))
			else
				table.insert(actions, self[self.bal_special](self))
			end
		end
    local attack_str = table.concat(actions, self.settings.sep)
    if string.upper(attack_str)==attack_queued then
      return
    end
		send("queue addclear eqbal "..table.concat(actions, self.settings.sep))
		return table.concat(actions, self.settings.sep)
	end
