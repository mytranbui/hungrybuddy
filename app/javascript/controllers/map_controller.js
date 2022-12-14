import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    console.log(this.markersValue.length > 1);
    if (this.markersValue.length > 1) {
      this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken, mapboxgl: mapboxgl }))
    }
  }


    #addMarkersToMap() {
      this.markersValue.forEach((marker) => {
          const popup = new mapboxgl.Popup().setHTML(marker.info_window)

          const customMarker = document.createElement("div")
          customMarker.className = "marker"
          customMarker.style.backgroundImage = `url('${marker.image_url}')`
          customMarker.style.backgroundSize = "fill"
          customMarker.style.backgroundRepeat = "no-repeat"
          customMarker.style.width = "40px"
          customMarker.style.height = "40px"

          new mapboxgl.Marker(customMarker)
            .setLngLat([ marker.lng, marker.lat ])
            .setPopup(popup)
            .addTo(this.map)
        })
    }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
