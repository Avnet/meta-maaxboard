document.addEventListener("DOMContentLoaded",function(){
	const thermostat = new Thermostat(".temp");
});

class Thermostat {
	constructor(el) {
		this.el = document.querySelector(el);
		this.temp = 9;
		this.tempMin = 9;
		this.tempMax = 32;
		this.fizz = null;
		this.fizzParticleCount = 600;
		this.fizzParticles = [];
		this.fc = null;
		this.fW = 240;
		this.fH = 240;
		this.fS = window.devicePixelRatio;
		this.init();
	}
	init() {
		window.addEventListener("keydown",this.kbdEvent.bind(this));

		if (this.el) {
			this.fizz = this.el.querySelector(".temp__fizz");
			if (this.fizz) {
				this.fc = this.fizz.getContext("2d");

				let f = this.fizzParticleCount;

				while (f--) {
					this.fizzParticles.push(
						{
							radius: 1, 
							// from center to comet ring
							minDist: this.randInt(100,115),
							maxDist: this.randInt(85,115),
							// rotation along the comet ring circumference
							minRot: this.randInt(-180,180),
							maxRot: this.randInt(-180,180),
							// position
							x: 0, 
							y: 0
						}
					);
				}

				this.fizz.width = this.fW * this.fS;
				this.fizz.height = this.fH * this.fS;
				this.fc.scale(this.fS,this.fS);
			}
		}

		Draggable.create(".temp__dial",{
			type: "rotation",
			bounds: {
				minRotation: 0, 
				maxRotation: 359
			},
			onDrag: () => {
				this.tempAdjust("drag");
			}
		});
	}
	degToRad(deg) {
		return deg * (Math.PI / 180);
	}
	randInt(min,max) {
		return Math.round(Math.random() * (max - min)) + min;
	}
	angleFromMatrix(transVal) {
		let matrixVal = transVal.split('(')[1].split(')')[0].split(','),
			[cos1,sin] = matrixVal.slice(0,2),
			angle = Math.round(Math.atan2(sin,cos1) * (180 / Math.PI)) * -1;
		
		// convert negative angles to positive
		if (angle < 0)
			angle += 360;
		
		if (angle > 0)
			angle = 360 - angle;
		
		return angle;
	}
	kbdEvent(e) {
		let kc = e.keyCode;

		if (kc) {
			// up or right
			if (kc == 38 || kc == 39)
				this.tempAdjust("u");
			// left or down
			else if (kc == 37 || kc == 40)
				this.tempAdjust("d");
		}
	}
	tempAdjust(inputVal) {
		/*
		inputVal can be the temp as an integer, "u" for up, 
		"d" for down, or "drag" for dragged value
		*/
		if (this.el) {
			let cs = window.getComputedStyle(this.el),
				tempDisplay = this.el.querySelector(".temp__value"),
				tempDial = this.el.querySelector(".temp__dial"),
				tempRange = this.tempMax - this.tempMin,
				hueStart = 240,
				hueEnd = 360,
				hueRange = hueEnd - hueStart,
				notDragged = inputVal != "drag";
			// input is an integer
			if (!isNaN(inputVal)) {
				this.temp = inputVal;
			// input is a given direction
			} else if (inputVal == "u") {
				if (this.temp < this.tempMax)
					++this.temp;

			} else if (inputVal == "d") {
				if (this.temp > this.tempMin)
					--this.temp;
			// GreenSock drag was used
			} else if (inputVal ==  "drag") {
				if (tempDial) {
					let tempDialCS = window.getComputedStyle(tempDial),
						trans = tempDialCS.getPropertyValue("transform"),		
						angle = this.angleFromMatrix(trans);

					this.temp = (angle / 360) * tempRange + this.tempMin;
				}
			}
			// keep the temperature within bounds
			if (this.temp < this.tempMin)
				this.temp = this.tempMin;
			else if (this.temp > this.tempMax)
				this.temp = this.tempMax;
			// use whole number temperatures for keyboard control
			if (notDragged)
				this.temp = Math.round(this.temp);

			let relTemp = this.temp - this.tempMin,
				frac = relTemp / tempRange,
				angle = frac * 360,
				newHue = hueStart + (frac * hueRange);

			// fizz
			let c = this.fc;
			if (c) {
				c.clearRect(0,0,this.fW,this.fH);
				c.fillStyle = `hsla(${newHue},100%,50%,0.5)`;
				c.globalAlpha = 0.25 + (0.75 * frac);

				let centerX = this.fW / 2,
					centerY = this.fH / 2,
					fizzCount = this.fizzParticles.length;

				this.fizzParticles.forEach((p,i) => {
					let pd = p.minDist + frac * (p.maxDist - p.minDist),
						pa = p.minRot + frac * (p.maxRot - p.minRot);

					p.x = centerX + pd * Math.sin(this.degToRad(pa));
					p.y = centerY + pd * Math.cos(this.degToRad(pa));

					c.beginPath();
					c.arc(p.x,p.y,p.radius,0,Math.PI * 2);
					c.fill();
					c.closePath();
				});
			}
			// CSS variables
			this.el.style.setProperty("--angle",angle);
			this.el.style.setProperty("--hue",newHue);
			// hidden dial
			if (tempDial && notDragged)
				tempDial.style.transform = `rotate(${angle}deg)`;
			// display value
			if (tempDisplay)
				tempDisplay.textContent = Math.round(this.temp);
		}
	}
}