screen = UI.ScreenSize()
center = {x=screen.width/2, y=screen.height/2}

--------------------------------------------------------------------------------------------------
-- 속도계만 샘플용으로 만든거라 나중에 기능 추가할 생각 없고 임의로 수정하는 걸 추천하지 않음 -익스트림버니합-

GroundSpeed = UI.SyncValue.Create(string.format("No.%i", UI.PlayerIndex()))

Playerspeed = UI.Text.Create()
Playerspeed:Set({font="small", align="center", y=screen.height/5*2, width=screen.width, height=50, r=255,g=255,b=255})

Panel = {}

speedmeter = {}
for i = 1, 9 do
	speedmeter[i] = {}
	for d = 1, 20 do
		speedmeter[i][d] = UI.Box.Create()
		Panel[#Panel + 1] = speedmeter[i][d]
	end
end

X = screen.width-250
Y = screen.height-150
W = 20
H = 30
WD = 5
HD = 15

for d = 1, 20 do
	for i = 1, 9 do
		speedmeter[i][d]:Set({x=X+((i-1)*W)+((i-1)*WD)+d, y=Y-((i-1)*(i*2)), width=1, height=H+((i-1)*(i*2)), r=255,g=255,b=255,a=60})
	end
	speedmeter[8][d]:Set({r=255,g=0,b=0})
	speedmeter[9][d]:Set({r=255,g=0,b=0})
end

Speed_Shadow = UI.Text.Create()
Speed_Shadow:Set({text='0', font='large', align='right', x=X-35, y=Y-125, width=150, height=50, r=30,g=30,b=30,a=155})

Speed = UI.Text.Create()
Speed:Set({text='0', font='large', align='right', x=X-40, y=Y-130, width=150, height=50, r=255,g=255,b=255,a=220})

Unit = UI.Text.Create()
Unit:Set({text='unit\n/sec', font='small', align='left', x=X+125, y=Y-128, width=50, height=50, r=255,g=255,b=255,a=220})

Line = UI.Box.Create()
Line:Set({x=X-5, y=Y-90, width=130, height=1, r=255,g=255,b=255,a=220})

Bar = UI.Box.Create()
Bar:Set({x=X+1, y=Y+36, height=3, r=255,g=255,b=255,a=220})

Mark = UI.Box.Create()
Mark:Set({x=X, y=Y+34, width=3, height=7, r=255,g=0,b=0,a=220})

function GroundSpeed:OnSync()
	str = math.floor(self.value)
	Playerspeed:Set({text=string.format("%d units/sec", str)})
	Speed:Set({text=string.format(str)})
	Speed_Shadow:Set({text=string.format(str)})
	
	for i = 1, #Panel do
		local unit = str/2.5
		if i <= unit - (math.floor(unit/25)*5) then
			Panel[i]:Set({a=220})
		else
			Panel[i]:Set({a=60})
		end
		
		Bar:Set({width=unit})
		Mark:Set({x=X+unit})
	end
end