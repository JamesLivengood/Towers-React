export const towerInfo = (tower) => {
    return {
        tower_type: tower.tower_type,
        date_constructed: tower.date_constructed,
        height_of_structure: tower.height_of_structure,
        ground_elevation: tower.ground_elevation,
        overall_height_above_ground: tower.overall_height_above_ground,
        overall_height_amsl: tower.overall_height_amsl,
        structure_type: tower.structure_type
    }
  }

export const transmitterInfo = (transmitter) => {
    return {
        sitetype: transmitter.sitetype,
        ground_elevation: transmitter.ground_elevation,
        height_of_support_structure: transmitter.height_of_support_structure,
        overall_height_of_structure: transmitter.overall_height_of_structure,
        structure_type: transmitter.structure_type,
        emmitter_1_freqs_mhz: transmitter.emmitter_1_freqs_mhz,
        emmitter_2_freqs_mhz: transmitter.emmitter_2_freqs_mhz,
        emmitter_3_freqs_mhz: transmitter.emmitter_3_freqs_mhz,
        emmitter_4_freqs_mhz: transmitter.emmitter_4_freqs_mhz,
        emmitter_5_freqs_mhz: transmitter.emmitter_5_freqs_mhz
    }
}