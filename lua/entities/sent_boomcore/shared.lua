-- Made with Dr. Matt's Base Core v3
ENT.Base 			= "base_core3"
ENT.PrintName		= "Boom Core" -- The name the Core will come up as in the Spawnmenu
ENT.Spawnable		= true -- If true, Anyone can spawn the entity
ENT.AdminSpawnable	= true -- If true, Admins can spawn the entity, Set ENT.Spawnable to false to make the Core Admin only.
ENT.Author			= "Dr. Matt" -- Self Explanatory, The author of the addon, AKA Your name.
ENT.Contact			= "Facepunch (MattJeanes)" -- Your contact, Perhaps an email address or a Steam username
ENT.Purpose			= "Gotta get get." -- The purpose of the entity
ENT.Instructions	= "" -- The instructions of the entity, Perhaps "Insert 1 chocolate cookie to activate."
ENT.Category		= "Portal 2 Cores"
ENT.Animation		= "sphere_idle_shiver_all" -- Set's the animation of the core, Look in Portal 2 Authoring Tools for more info.
ENT.Dir				= "boom" -- The name of your sub-folder, must be 4 characters.
ENT.MusicCore		= true
/*---------------------------------------------------------
	ENT.Dir: Put your stuff in the following folders:
	
	sound/cores/(ENT.Dir)/
	sound/cores/(ENT.Dir)/special/ -- For use.wav, undo.wav and dmg.wav
	models/cores/(ENT.Dir)/
	materials/models/cores/(ENT.Dir)/
---------------------------------------------------------*/

if SERVER then AddCSLuaFile() end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Think()
    if CLIENT then return false end
    
    if ((CurTime() - self.SayTimer) > 13.78) then    
        local intensity = 3 + math.Clamp((CurTime() - self.SayTimer - 13.78) / 5.0, 0, 1) * 12
        local intensitycam = intensity * 0.5
        
        for k,ent in pairs( ents.FindInSphere( self:GetPos(), 768 ) ) do
            if IsValid( ent ) and ent:GetPhysicsObject() ~= nil and ent:GetPhysicsObject():IsValid() then
                local phys = ent:GetPhysicsObject()
                
                phys:Wake()
                phys:ApplyForceCenter( VectorRand() * intensity )
                phys:AddAngleVelocity( VectorRand() * intensity * phys:GetMass() )
                
            end
            
            if IsValid( ent ) and ent:IsPlayer() then
                ent:ViewPunch( Angle( math.random(-intensitycam, intensitycam), math.random(-intensitycam, intensitycam), math.random(-intensitycam, intensitycam) ) )
                
            end
            
        end
        
    end
    
    
    self:NextThink( CurTime() + 0.1 )
    return true
    
end