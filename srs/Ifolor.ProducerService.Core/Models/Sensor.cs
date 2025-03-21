﻿using IfolorProducerService.Core.Enums;

namespace IfolorProducerService.Core.Models
{
    public class Sensor
    {
        public required string SensorId { get; set; }
        public int Interval { get; set; } // delay in miliseconds
        public MeasurementType MeasurementType { get; set; }
        public required Func<double> GenerateData { get; set; } // generage random data
    }
}
