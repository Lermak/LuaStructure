SoundManager = {
}

function SoundManager:AddSound(file)
  self.SoundQueue[#self.SoundQueue+1] = love.audio.newSource("assets/Sound/"..file, "stream")
end

function SoundManager:SetAmbiantSound(file)
  self.AmbiantSound = love.audio.newSource("assets/Sound/"..file, "stream")
  self.AmbiantSound:setLooping(true)
  self.AmbiantSound:play()
end

function SoundManager:Load()
  self.SoundQueue = {}
  self.AmbiantSound = nil
end

function SoundManager:Update()
  for k, v in pairs(self.SoundQueue) do
    v:play()
    self.SoundQueue[k] = nil
  end
end