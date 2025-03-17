﻿using IfolorProducerService.Application.Services;
using IfolorProducerService.Core.Enums;
using IfolorProducerService.Core.Generator;
using IfolorProducerService.Core.Models;

namespace IfolorProducerService.Application.Generator
{
    public class SensorDataGenerator : ISensorDataGenerator
    {
        public SensorData GenerateData(Sensor sensor)
        {
            var measurements = sensor.GenerateData();
            return new SensorData
            {
                EventId = Guid.NewGuid(),   
                SensorId = sensor.SensorId,
                Timestamp = DateTime.UtcNow,
                MeasurementType = sensor.MeasurementType,
                MeasurementValue = measurements,
                EventStatus = EventStatus.Send
            };
        }
    }
}
