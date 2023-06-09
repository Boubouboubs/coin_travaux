import { Controller } from "@hotwired/stimulus";
import { connect, createLocalVideoTrack } from 'twilio-video';

export default class extends Controller {
  static values = {
    accessToken: String,
    roomId: String,
    buddyVideoWidth: {
      type: Number,
      default: 640
    }
  }

  static targets = ['localVideo', 'buddyVideo', 'noCall', 'awaitingBuddy', 'joinCallButton', 'endCallButton']

  connect() {
    if (!this.accessTokenValue) {
      console.error('You must provide a value for access-token!')
    }
    if (!this.roomIdValue) {
      console.error('You must provide a value for room-id!')
    }
    if (!this.localVideoTarget) {
      console.error('You must provide a `local-video-target`!')
    }
    if (!this.buddyVideoTarget) {
      console.error('You must provide a `buddy-video-target`!')
    }
  }

  _showLocalVideo(visible) {
    if (visible) {
      createLocalVideoTrack().then(track => {
        this.localVideoTarget.appendChild(track.attach())
        // this.buttonStartTarget.classList.add("d-none")
      })
    } else {
      this.room.localParticipant.tracks.forEach(publication => {
        const attachedElements = publication.track.detach()
        attachedElements.forEach(element => element.remove())
        // this.buttonEndTarget.classList.add("d-none")
      })
      this.localVideoTarget.innerHTML = ''
    }
  }

  _showBuddyVideo(track) {
    if (track) {
      this.buddyVideoTarget.appendChild(track.attach())
    } else {
      const streamElements = this.buddyVideoTarget.querySelectorAll('video, audio')
      if (streamElements) {
        streamElements.forEach(element => {
          element.parentNode.removeChild(element)
        })
      }
      this.room.disconnect()
    }
  }

  _onSelfConnect() {
    this.callStarted()

    // Someone is already in the room
    if (this.room.participants.size > 0) {
      this.buddyJoined()
    }
    // Show video for each participant in the room
    this.room.participants.forEach(participant => {
      participant.tracks.forEach(publication => {
        if (publication.track) {
          this._showBuddyVideo(publication.track)
        }
      })

      // If a participant starts sharing video later,
      // show their video
      participant.on('trackSubscribed', track => {
        this._showBuddyVideo(track)
      })
    })
  }

  _onBuddyConnect(buddy) {
    buddy.tracks.forEach(publication => {
      if (publication.isSubscribed) {
        const track = publication.track
        this._showBuddyVideo(track)
      }
    })
    this.buddyJoined()

    buddy.on('trackSubscribed', track => {
      this._showBuddyVideo(track)
    })
  }

  _onBuddyDisconnect() {
    this.buddyLeft()
    this.endCall()
  }

  joinCall(event) {
    event.preventDefault()
    this._showLocalVideo(true)
    connect(this.accessTokenValue, {
      name: this.roomIdValue,
      audio: true,
      video: { width: this.buddyVideoWidthValue }
    }).then(
      room => {
        this.room = room
        this._onSelfConnect()

        room.on('participantConnected', (buddy) => {
          this._onBuddyConnect(buddy)
        })
        room.on('participantDisconnected', () => this._onBuddyDisconnect())
        room.on('disconnected', () => this.endCall())
      },
      error => {
        console.error(`Unable to connect to room: ${error.message}`)
      }
    )
  }

  endCall(event) {
    event && event.preventDefault()
    this._showBuddyVideo(false)
    this._showLocalVideo(false)
    this.callEnded()

  }

  callStarted() {
    this.noCallTarget.classList.add('d-none')
    this.awaitingBuddyTarget.classList.remove('d-none')
    // this.joinCallButtonTarget.classList.add('d-none')
    // this.endCallButtonTarget.classList.remove('d-none')
  }

  callEnded() {
    this.noCallTarget.classList.remove('d-none')
    this.awaitingBuddyTarget.classList.add('d-none')
    // this.joinCallButtonTarget.classList.remove('d-none')
    // this.endCallButtonTarget.classList.add('d-none')
  }

  buddyJoined() {
    this.awaitingBuddyTarget.classList.add('d-none')
  }

  buddyLeft() {
  }

  // callStarted(event) {
  //   this.buttonStartTarget.classList.add("d-none")
  //   this.buttonEndTarget.classList.remove("d-none")
  // }

  // callEnded(event) {
  //   this.buttonEndTarget.classList.add("d-none")
  //   this.buttonStartTarget.classList.remove("d-none")
  // }

  // buddyJoined() {}

  // buddyLeft() {}
}
