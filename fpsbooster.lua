-- FPS Booster
local function fps_booster()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 0
            v.BlastRadius = 0
        end
    end
end

fps_booster()

print("Executed successfully script make by isadaam")
